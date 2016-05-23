class Post 
	include HTTParty
	base_uri 'beingmango.com/wp-json/wp/v2/posts'
	class << self
		@@attributes=["id","title","excerpt","content","categories","tags"]
		def all
			posts=HTTParty.get(base_uri)
			posts.each {|post| post.slice!(*@@attributes)}
		end

		def find id
			post_id=id[:id].to_i
			post=HTTParty.get(base_uri+"/#{post_id}")
			if post.blank?
				post.slice!(*@@attributes)
			end	
			post
		end	
	end	
	
end	