class BlogUpdate
  include HTTParty
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
      minutely(15)
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
      if cache_post_id != post_id
        #remove current cache
        $redis.del("posts")
        #save cache with updated data
        $redis.set("posts", posts)
        cache_categories = $redis.get("categories")
        cache_tags = $redis.get("tags")
        if cache_categories.nil?
          posts.each do |post|
            post_categories << post["categories"]
            post_tags << post["tags"]
          end
          post_categories.flatten!
          post_tags.flatten!
          $redis.set("categories",post_categories.uniq! )
          $redis.set("tags",post_tags.uniq!)
        else
          cache_count=cache_posts.length
          post_count = posts.length
          #if new posts
          if post_count < cache_count
            (0..post_count).each do |i|
              post_categories << posts[i]["categories"]
              post_tags << posts[i]["tags"]
            end
            cache_categories = cache_categories.uniq!
            cache_tags = cache_tags.uniq!
            post_categories = post_categories.uniq!
            post_tags = post_tags.uniq!
            ##update categories cache
            if not cache_categories.include?(post_categories)
              $redis.del("categories")
              $redis.set("categories",post_categories.uniq! )
            end
            ##update tags cache
            if not cache_tags.include?(post_tags)
              $redis.del("tags")
              $redis.set("tags",post_tags.uniq!)
            end
          end
        end
      end
    end
  end
end
