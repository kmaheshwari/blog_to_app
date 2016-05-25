class Tag 
	include HTTParty
	base_uri 'beingmango.com/wp-json/wp/v2/tags'
	class << self
		@@attributes=["id","name","slug"]
		def all
			tags=HTTParty.get(base_uri)
			tags.each {|tag| tag.slice!(*@@attributes)}
		end

		def find id
			tag_id=id[:id].to_i
			tag=HTTParty.get(base_uri+"/#{tag_id}")
			if tag.blank?
				tag.slice!(*@@attributes)
			end	
			tag
		end	
	end	
	
end	