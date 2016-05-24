module PostHelper
	include HTTParty
	base_uri 'beingmango.com/wp-json/wp/v2/posts'
	@@attributes=["id","title","excerpt","content","categories","tags"]
	def fetch_posts
		posts = $redis.get("posts")
		if posts.nil?
		  posts=HTTParty.get(base_uri)
		  posts.each {|post| post.slice!(*@@attributes)}
		  $redis.set("posts", posts)
		else
			eval posts  
		end	
	end	

	def fetch id
		post_id=id[:id].to_i
		post=$redis.get("posts")
		post=eval post

		if post.nil?
			post=HTTParty.get(base_uri+"/#{post_id}")
			post.slice!(*@@attributes)
		else
			record={}
			post.map do |p|
				if p["id"]==post_id
					record=p
					break
				end	
			end
		end	
		record
	end	
end
