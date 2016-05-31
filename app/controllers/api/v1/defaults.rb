module API
  module V1
    module Defaults
      extend ActiveSupport::Concern
      
      included do
        ActionController::HttpAuthentication::Token
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def current_url
              # base_url=App.find_by_access_token(headers['Authorization']).app_url
              base_url="androidhive.info"
              base_url+="/?json="
          end  

            

          def logger
            Rails.logger
          end
        end
        #api authentication
        #before do
         # access=App.find_by_access_token(headers['Authorization'])
          #if !access.nil?
           # error!('Unauthorized', 401) unless not access.access_token.nil?
          #else  
           # error!('Unauthorized', 401)
          #end  
        #end

      end
    end

  end
end
