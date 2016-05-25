class BlogUpdate
  include HTTParty
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
      minutely(1)
  end

  def perform
    #get current cache data
    cache_posts = $redis.get("posts")
    cache_posts = eval cache_posts
    #get data from blog
    posts = HTTParty.get('http://beingmango.com/wp-json/wp/v2/posts')
    post_id=posts[0]["id"]
    if cache_posts.nil?
      $redis.set("posts", posts)
    else
      cache_post_id = cache_posts[0]["id"]
      #if blog updated
      if cache_post_id == post_id
        #remove current cache
        $redis.del("posts")
        #save cache with updated data
        $redis.set("posts", posts)
        #categories cache
        $redis.del("categories")
        categories=HTTParty.get('http://beingmango.com/wp-json/wp/v2/categories')
        if not categories.nil?
          category_hash=[]
          categories.each do |category| 
            category_hash << category.extract!("id","name","slug")
          end
          $redis.set("categories",category_hash)
        end
        #tags cache
        $redis.del("tags")
        tags=HTTParty.get('http://beingmango.com/wp-json/wp/v2/tags')
        if not tags.nil?
          tag_hash=[]
          tags.each do |tag| 
            tag_hash << tag.extract!("id","name","slug")
          end
          $redis.set("tags",tag_hash)
        end
        
      end
    end
  end
end
