module CategoryHelper
	include HTTParty
	@@attributes=["id","title"]	
	def fetch_categories base_uri
	  categories=HTTParty.get("http://"+base_uri)
	  categories=categories["categories"]
	  categories.each {|category| category.slice!(*@@attributes)}
	  categories
	end	

	def populate base_uri
		categories=HTTParty.get(base_uri+"/?json=get_category_index")
		
		if !categories.nil?
			categories=categories["categories"]
			if categories=="categories" || categories.nil?
				nil
			else	
				categories.each {|category| category.slice!("title")}
				categories
			end	
		end	
	end	
end
