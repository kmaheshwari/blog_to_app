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
		categories=categories["categories"]
		categories.each {|category| category.slice!("title")}

		pages=HTTParty.get(base_uri+"/?json=get_page_index")
		pages=pages["pages"]
		pages.each {|page| page.slice!("title")}
		
		{"categories" => categories, "pages"=>pages}
	end	
end
