module PostHelper
	include HTTParty
	@@attributes=["id","title","author","categories","thumbnail_images","url"]
	@@category_attributes=["id","title"]
	@@single_attributes=["id", "title","author","content", "categories","date","thumbnail_images","url"]
	def fetch_posts base_uri, page, count, category_id
		  if page.nil? || page.blank?
		  	page=1
		  else	
		  	page=page[0].to_i
		  end
		  if count.nil? || count.blank?
		  	count=15
		  else	
		  	count=count[0].to_i
		  end	
		  if category_id.nil? || category_id.blank?
		  	posts=HTTParty.get("http://"+base_uri+"get_posts&page=#{page}&count=#{count}")
		  else
		  	category_id=category_id[0].to_i
		  	posts=HTTParty.get("http://"+base_uri+"get_category_posts&id=#{category_id}&page=#{page}&count=#{count}")
		  end	
		  posts=posts["posts"]
		  posts.each do |post| 
		  	post.slice!(*@@attributes)
		  	post["author"]=post["author"]["name"]
		  	if !post["thumbnail_images"].nil?
			  	post["image"]={"small"=>post["thumbnail_images"]["thumbnail"]["url"]}
			  	post["image"]["medium"]=post["thumbnail_images"]["medium"]["url"]
			  	post["image"]["large"]=post["thumbnail_images"]["full"]["url"]
			  	post.delete("thumbnail_images")
			else
				post["image"]=nil  	
			end  	
		  	post["categories"].each do |category|
		  		category.slice!(*@@category_attributes)
		  	end	
		  end
		  {"posts"=>posts}
	end	

	def fetch id, base_uri
		post_id=id.to_i
		post=HTTParty.get("http://"+base_uri+"#{post_id}")
		post=post["post"]
		post.slice!(*@@single_attributes)


		post["author"]=post["author"]["name"]
		if !post["thumbnail_images"].nil?
			post["image"]={"small"=>post["thumbnail_images"]["thumbnail"]["url"]}
			post["image"]["medium"]=post["thumbnail_images"]["medium"]["url"]
			post["image"]["large"]=post["thumbnail_images"]["full"]["url"]
			post.delete("thumbnail_images")
		else
			post["image"]=nil
		end	
		post["categories"].each do |category|
			category.slice!(*@@category_attributes)
		end
		post["timestamp"]=post["date"]
		post.delete("date")
		post
	end	

end
