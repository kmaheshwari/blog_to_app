module API
  module V1
    class Base < Grape::API
      mount API::V1::Posts
      mount API::V1::Categories
      mount API::V1::Tags
    end
  end
end
