module API
  module V1
    class Categories < Grape::API
      include API::V1::Defaults
      helpers CategoryHelper

      resource :categories do
        desc "Return all categories"
        get "", root: :categories do
          fetch_categories current_url+"/categories", app_key
        end

        desc "Return a category"
        params do
          requires :id, type: String, desc: "ID of the category"
        end
        get ":id", root: "category" do
          fetch(params[:id],current_url+"/posts",app_key)
        end 
      end

    end
  end
end
