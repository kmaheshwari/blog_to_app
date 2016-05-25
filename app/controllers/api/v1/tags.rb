module API
  module V1
    class Tags < Grape::API
      include API::V1::Defaults

      resource :tags do
        desc "Return all tags"
        get "", root: :tags do
          Tag.all
        end

        desc "Return a tag"
        params do
          requires :id, type: String, desc: "ID of the tag"
        end
        get ":id", root: "tag" do
          Tag.find(id: permitted_params[:id])
        end 
      end
    
    end
  end
end
