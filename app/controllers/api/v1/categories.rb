module API
  module V1
    class Categories < Grape::API
      include API::V1::Defaults
      helpers CategoryHelper

      resource :categories do
        desc "Return all categories"
        get "", root: :categories do
          fetch_categories current_url+"get_category_index"
        end
      end
    end
  end
end
