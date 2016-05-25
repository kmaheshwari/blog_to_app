module API
  module V1
    class Categories < Grape::API
      include API::V1::Defaults
      helpers CategoryHelper

      resource :categories do
        desc "Return all categories"
        get "", root: :categories do
          fetch_categories
        end

        desc "Return a category"
        params do
          requires :id, type: String, desc: "ID of the category"
        end
        get ":id", root: "category" do
          fetch id: permitted_params[:id]
        end 
      end
    
    end
  end
end
