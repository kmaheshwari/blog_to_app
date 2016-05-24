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
        $redis.set("posts", posts)
      end
    end
  	   
  end

end
