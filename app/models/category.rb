class Category
	include HTTParty
	base_uri 'beingmango.com/wp-json/wp/v2/categories'
	class << self
		def all
			categories=HTTParty.get(base_uri)
		end		

		def find id
			category_id=id[:id].to_i
			category=HTTParty.get(base_uri+"/#{category_id}")																																																																																																																																																																																																													
		end
	end	
		

	
end	