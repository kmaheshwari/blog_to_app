$redis = Redis::Namespace.new("blog_to_app", :redis => Redis.new)