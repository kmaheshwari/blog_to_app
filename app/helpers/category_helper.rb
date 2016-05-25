module CategoryHelper
	include HTTParty
	base_uri 'beingmango.com/wp-json/wp/v2/categories'
	@@attributes=["id","name","slug"]	
	def fetch_categories
		categories = $redis.get("categories")
		if categories.nil?
		  categories=HTTParty.get(base_uri)
		  categories.each {|category| category.slice!(*@@attributes)}
		  $redis.set("categories", categories)
		else
			eval categories	
		end
	end	

	def fetch id
		category_id=id[:id].to_i
		category=$redis.get("categories")
		category=eval category

		if category.nil?
			category=HTTParty.get(base_uri+"/#{category_id}")
			category.slice!(*@@attributes)
		else
			record={}
			category.map do |p|
				if p["id"]==category_id
					record=p
					break
				end	
			end
		end	
		record
	end	
end
