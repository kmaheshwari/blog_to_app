class BlogUpdate
  include HTTParty
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
      minutely(15)
  end

  def perform
    @apps=App.all
    @apps.each do |app|
      base_url= 'http://beingmango.com'
      # base_url=app.app_url
      base_url += "/wp-json/wp/v2/"
      #get current cache data
      cache_posts = $redis.get("posts"+app.access_token)
      
      #get data from blog
      posts = HTTParty.get(base_url+'posts')
      post_id=posts[0]["id"]
      if cache_posts.nil?
        $redis.set("posts"+app.access_token, posts)
      else
        cache_posts = eval cache_posts
        cache_post_id = cache_posts[0]["id"]
        #if blog updated
        if cache_post_id == post_id
          #remove current cache
          $redis.del("posts"+app.access_token)
          #save cache with updated data
          $redis.set("posts"+app.access_token, posts)
          #categories cache
          $redis.del("categories"+app.access_token)
          categories=HTTParty.get(base_url+'categories')
          if not categories.nil?
            category_hash=[]
            categories.each do |category| 
              category_hash << (eval category.extract!("id","name","slug").to_s.gsub /&amp\;/, "&")
            end
            $redis.set("categories"+app.access_token,category_hash)
          end
          #tags cache
          $redis.del("tags"+app.access_token)
          tags=HTTParty.get(base_url+'tags')
          if not tags.nil?
            tag_hash=[]
            tags.each do |tag| 
              tag_hash << (eval tag.extract!("id","name","slug").to_s.gsub /&amp\;/, "&")
            end
            $redis.set("tags"+app.access_token,tag_hash)
          end
        end
      end
    end
  end
end
