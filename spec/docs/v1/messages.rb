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

      INDEX_PARAMS = {
        recipient_id: { type: :number, required: :required, value: 123 }
      }.freeze
      INDEX_PATH = '/api/v1/messages?recipient_id={recipient_id}'.freeze

      document :index do
        action 'Get recent messages' do
          params INDEX_PARAMS
          path INDEX_PATH
          desc <<~DESC
            Provided a recipient's ID, gets messages that were sent to that recipient.

            Gets the first 100 most recent messages,
            no older than 30 days, and ordered most-recent-first.
          DESC
        end
      end

      document :index_by_url do
        action 'Get recent messages (alternative)' do
          params INDEX_PARAMS
          path '/api/v1/recipents/{recipient_id}/messages'
          desc <<~DESC
            An alternative way to get a recipient's messages.
            Same behavior and results as `#{INDEX_PATH}`.
          DESC
        end
      end

      FILTERED_INDEX_PARAMS = {
        recipient_id: { type: :number, required: :required, value: 123 },
        sender_id: { type: :number, required: :required, value: 456 }
      }.freeze
      FILTERED_INDEX_PATH = "#{INDEX_PATH}&sender_id={sender_id}".freeze

      document :index_filtered do
        action 'Get recent messages from sender' do
          params FILTERED_INDEX_PARAMS
          path FILTERED_INDEX_PATH
          desc <<~DESC
            Provided a recipient's ID and a sender's ID,
            gets messages that were sent to that recipient.
            by that sender.

            Gets the first 100 most recent messages,
            no older than 30 days, and ordered most-recent-first.
          DESC
        end
      end

      document :index_by_url_filtered do
        action 'Get recent messages from sender (alternative)' do
          params FILTERED_INDEX_PARAMS
          path '/api/v1/recipents/{recipient_id}/sender/{sender_id}/messages'
          desc <<~DESC
            An alternative way to get a recipient's messages from a particular user.
            Same behavior and results as `#{FILTERED_INDEX_PATH}`.
          DESC
        end
      end

      POST_PARAMS = {
        "message.recipient_id": { type: :number, required: :required, value: 123 },
        "message.sender_id": { type: :number, required: :required, value: 456 },
        "message.text": { type: :text, required: :required, value: 'Hello' }
      }.freeze

      document :post do
        action 'Send a message' do
          params POST_PARAMS
          desc <<~DESC
            Saves a short text message, from a sender to a recipient.
            This message will show up in that recipient's recent messages.
          DESC
        end
      end
    end
  end
end
