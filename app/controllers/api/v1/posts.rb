module API
  module V1
    class Posts < Grape::API
      include API::V1::Defaults
      helpers PostHelper

      resource :posts do
        desc "Return all posts"
        get "", root: :posts do
          fetch_posts
        end

        desc "Return a post"
        params do
          requires :id, type: String, desc: "ID of the post"
        end
        get ":id", root: "post" do
          fetch id: permitted_params[:id]
        end 
      end

    end
  end
end
