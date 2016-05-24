class Category
	include HTTParty
	base_uri 'beingmango.com/wp-json/wp/v2/categories'
	class << self
		@@attributes=["id","name","slug"]
		def all
			categories=HTTParty.get(base_uri)
			categories.each {|category| category.slice!(*@@attributes)}
		end

		def find id
			category_id=id[:id].to_i
			category=HTTParty.get(base_uri+"/#{category_id}")
			if category.blank?
				category.slice!(*@@attributes)
			end	
			category
		end	
	end	
		

	
end	