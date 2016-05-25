module PostHelper
	include HTTParty
	@@attributes=["id","title","excerpt","content","categories","tags"]
	def fetch_posts base_uri, app_key
		posts = $redis.get("posts"+"#{app_key}")
		if posts.nil?
		  posts=HTTParty.get("http://"+base_uri)
		  posts.each {|post| post.slice!(*@@attributes)}
		  $redis.set("posts"+"#{app_key}", posts)
		  posts
		else
		  eval posts  
		end	
	end	

	def fetch id, base_uri, app_key
		post_id=id.to_i
		posts = $redis.get("posts"+"#{app_key}")

		if posts.nil?
			post=HTTParty.get("http://"+base_uri+"/#{post_id}")
			post.slice!(*@@attributes)
		else
			posts=eval posts
			record={}
			posts.map do |post|
				if post["id"]==post_id
					record=post
					break
				end	
			end
		end	
		record
	end	

end
