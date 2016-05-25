module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def current_url
              base_url=App.find(2).app_url
              base_url+="/wp-json/wp/v2"
          end  

          def app_key
              2
          end  

          def logger
            Rails.logger
          end
        end

      end
    end
  end
end
