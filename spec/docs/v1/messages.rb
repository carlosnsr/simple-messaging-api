module Docs
  module V1
    module Messages
      extend Dox::DSL::Syntax

      document :api do
        resource 'Messages' do
          endpoint '/messages'
          group 'Messages'
        end
      end

      GET_PARAMS = {
        recipient_id: { type: :number, required: :required, value: 123 }
      }.freeze
      INDEX_PATH = '/api/v1/messages?recipient_id={recipient_id}'.freeze

      document :index do
        action "Get recipient's recent messages" do
          params GET_PARAMS
          path INDEX_PATH
          desc <<~DESC
            Provided a recipient's ID, gets messages that were sent to that recipient.

            Gets the first 100 of the recipient's most recent messages,
            no older than 30 days, and ordered most-recent-first.
          DESC
        end
      end

      document :index_by_url do
        action "Get recipient's recent messages (alternative)" do
          params GET_PARAMS
          path '/api/v1/recipents/{recipient_id}/messages'
          desc <<~DESC
            An alternative way to get a recipient's messages.
            Same behavior and results as `#{INDEX_PATH}`.
          DESC
        end
      end

      POST_PARAMS = {
        recipient_id: { type: :number, required: :required, value: 123 },
        sender_id: { type: :number, required: :required, value: 456 },
        text: { type: :text, required: :required, value: 'Hello' }
      }.freeze

      document :post do
        action 'Post a message, from a sender to a recipient' do
          params POST_PARAMS
        end
      end
    end
  end
end
