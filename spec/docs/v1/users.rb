module Docs
  module V1
    module Users
      extend Dox::DSL::Syntax

      document :api do
        resource 'Users' do
          endpoint '/users'
          group 'Users'
        end
      end

      POST_PARAMS = {
        "user.name": { type: :string, required: :required, value: FFaker::Name.name }
      }.freeze
      POST_PATH = '/api/v1/users'.freeze

      document :post do
        action 'Create a user' do
          params POST_PARAMS
          path POST_PATH
          desc <<~DESC
            Provided with a name, creates a user with that name.

            Returns the user's ID
          DESC
        end
      end

      INDEX_PATH = POST_PATH.freeze

      document :index do
        action 'Get users' do
          path INDEX_PATH
          desc <<~DESC
            Returns a list of all the users currently in the system
          DESC
        end
      end
    end
  end
end

