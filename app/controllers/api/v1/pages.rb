module API
  module V1
    class Pages < Grape::API
      include API::V1::Defaults
      helpers PageHelper
      
      resource :pages do
        desc "Return a page"
        params do
          requires :slug, type: String, desc: "ID of the page"
        end
        get ":slug", root: "page" do
          current_url="api.androidhive.info/tmp/wptoblog/"
          fetch(params[:slug],current_url)
        end 
      end

    end
  end
end
