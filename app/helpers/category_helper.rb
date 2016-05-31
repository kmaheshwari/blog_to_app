module CategoryHelper
	include HTTParty
	@@attributes=["id","title"]	
	def fetch_categories base_uri
	  categories=HTTParty.get("http://"+base_uri)
	  categories=categories["categories"]
	  categories.each {|category| category.slice!(*@@attributes)}
	  categories
	end	
end
