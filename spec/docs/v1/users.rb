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

      POST_PATH = '/api/v1/users'.freeze

      document :post do
        action 'Create a user' do
          path POST_PATH
          desc <<~DESC
            Provided with a name, creates a user with that name.

            Returns the user's ID
          DESC
        end
      end
    end
  end
end

