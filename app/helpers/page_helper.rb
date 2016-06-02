module PageHelper
	include HTTParty
	@@single_attributes=["id", "title","author","content", "categories","date","thumbnail_images"]

	def fetch slug, base_uri
		pages=HTTParty.get("http://"+base_uri+"#{slug}"+".json")
		pages
		#pages=pages["pages"]
		#page=pages.select {|page| page["slug"]==slug}
		#if !page.nil? && !page.blank?
			#page=page[0]
			#page.slice!(*@@single_attributes)
			#page["author"]=page["author"]["name"]
			#page["timestamp"]=page["date"]
			#page.delete("date")
			#page.keys.map {|pk| page[pk]=nil if page[pk].blank?}
			#page["thumbnail_images"]=nil if !page.key?("thumbnail_images")
			#page			
		#else
		#	{}
		#end	
	end	
	def page_populate base_uri
		pages=HTTParty.get(base_uri+"/?json=get_page_index")
		
		if !pages.nil?
			pages=pages["pages"]
			if pages=="pages" || pages.nil?
				nil
			else	
				pages.each {|page| page.slice!("title")}
				pages
			end	
		end	
	end
end
