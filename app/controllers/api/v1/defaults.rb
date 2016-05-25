module API
  module V1
    module Defaults
      extend ActiveSupport::Concern
      # include ActionController::HttpAuthentication::Token::ControllerMethods
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

          def logger
            Rails.logger
          end
        end
        #api authentication
        before do
          access=App.where(access_token: headers['Authorization'])
          error!('Unauthorized', 401) unless not access.empty?
        end

      end
    end

  end
end
