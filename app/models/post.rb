class Post 
	include HTTParty
	base_uri 'beingmango.com/wp-json/wp/v2/posts'
	class << self
		def all
			posts=HTTParty.get(base_uri)			
		end		

		def find id
			post_id=id[:id].to_i
			post=HTTParty.get(base_uri+"/#{post_id}")			
		end
	end
end	