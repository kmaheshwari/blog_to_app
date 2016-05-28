module CategoryHelper
	include HTTParty
	@@attributes=["id","name","slug"]	
	def fetch_categories base_uri, app_key
		categories = $redis.get("categories"+"#{app_key}")
		if categories.nil?
		  categories=HTTParty.get("http://"+base_uri)
		  categories.each {|category| category.slice!(*@@attributes)}
		  $redis.set("categories"+"#{app_key}", categories)
		  categories
		else
		  eval categories  
		end	
	end	

	def fetch id, base_uri, app_key
		category_id=id.to_i
		categories = $redis.get("categories"+"#{app_key}")

		if categories.nil?
			category=HTTParty.get("http://"+base_uri+"/#{category_id}")
			category.slice!(*@@attributes)
		else
			categories=eval categories
			record={}
			categories.map do |category|
				if category["id"]==category_id
					record=category
					break
				end	
			end
		end	
		record
	end	
end
