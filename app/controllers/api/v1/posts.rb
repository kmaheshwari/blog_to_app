module API
  module V1
    class Posts < Grape::API
      include API::V1::Defaults
      helpers PostHelper
      
      resource :posts do
        desc "Return all posts"
        get "", root: :posts do
            url = request.fullpath
            uri=URI.parse(url)

            if uri.query.nil?
              fetch_posts current_url+"get_posts",nil, nil, nil
            else
              uri_params=CGI.parse(uri.query)
              fetch_posts current_url, uri_params["page"], uri_params["count"], uri_params["category_id"]
            end 
        end

        desc "Return a post"
        params do
          requires :id, type: String, desc: "ID of the post"
        end
        get ":id", root: "post" do
          fetch(params[:id],current_url+"get_post&post_id=")
        end 
      end

    end
  end
end
