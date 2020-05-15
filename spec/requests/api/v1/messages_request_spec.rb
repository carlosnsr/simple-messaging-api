# frozen_string_literal: true

require 'rails_helper'

def returned_message(message)
  {
    sender_id: message.sender.id,
    recipient_id: message.recipient.id,
    text: message.text,
    timestamp: message.created_at
  }
end

RSpec.describe 'Api::V1::Messages', type: :request do
  include Docs::V1::Messages::Api

  describe 'POST' do
    include Docs::V1::Messages::Post

    let(:sender) { create(:user) }
    let(:recipient) { create(:user) }
    let(:text) { FFaker::HipsterIpsum.phrase }
    let(:valid_params) do
      {
        sender_id: sender.id,
        recipient_id: recipient.id,
        text: text
      }
    end

    # Given valid parameters, create it and return the message's id and timestamp
    context 'given a sender, a recipient, and text' do
      it 'is successful' do
        post api_v1_messages_path(params: valid_params)
        expect(response).to have_http_status(:created)
      end

      it 'saves creates the message' do
        expect { post api_v1_messages_path(params: valid_params) }
          .to change { Message.count }.by(1)
      end

      it 'returns the message id and timestamp', :dox do
        post api_v1_messages_path(params: valid_params)
        last_message = Message.all.last
        expect(response.body).to eq(
          {
            message: {
              id: last_message.id,
              timestamp: last_message.created_at
            }
          }.to_json
        )
      end
    end

    # If any of these params (sender_id, recipient_id, text) is missing,
    # return an error pointing out the missing item
    RSpec.shared_examples 'missing_parameter' do |key|
      context "no #{key}" do
        let(:new_params) { valid_params.reject { |k, _v| k == key } }

        it "returns an error, if #{key} is missing", :dox do
          post api_v1_messages_path(params: new_params)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq(
            { error: "param is missing or the value is empty: #{key}" }.to_json
          )
        end
      end
    end

    context 'if any required parameter is missing' do
      around(:example) do |example|
        expect(&example).not_to change { Message.count }
      end

      include_examples 'missing_parameter', :recipient_id
      include_examples 'missing_parameter', :sender_id
      include_examples 'missing_parameter', :text
    end
  end
end

RSpec.shared_examples 'retrieve_recipient_messages' do
  let(:recipient) { create(:user) }

  context 'recipient with no messages' do
    it 'is successful' do
      get path
      expect(response).to have_http_status(:ok)
    end

    it 'returns empty array of messages' do
      get path
      expect(response.body).to eq({ messages: [] }.to_json)
    end
  end

  context 'recipient with messages' do
    let!(:message) { create(:message, recipient: recipient) }
    let!(:older_message) do
      create(:message, recipient: recipient) do |message|
        message.created_at = 1.day.ago
        message.save
      end
    end

    it 'returns the message', :dox do
      get path
      expect(response.body).to eq(
        {
          messages: [
            returned_message(message),
            returned_message(older_message)
          ]
        }.to_json
      )
    end
  end

  context 'recipient with over 100 messages' do
    it 'returns only the first 100 messages' do
      create_list(:message, 150, recipient: recipient)
      get path
      expect(JSON.parse(response.body)['messages'].count).to eq(100)
    end
  end

  context "recipient that doesn't exist" do
    let(:recipient) { build(:user, id: 1234) }
    it 'returns an error if the recipient does not exist', :dox do
      get path
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq(
        { error: "recipient #{recipient.id} does not exist" }.to_json
      )
    end
  end
end

RSpec.describe 'Api::V1::Messages', type: :request do
  include Docs::V1::Messages::Api

  describe 'GET /messages?recipient_id' do
    include Docs::V1::Messages::Index

    let(:valid_params) { { recipient_id: recipient.id } }
    let(:path) { api_v1_messages_path(params: valid_params) }

    include_examples 'retrieve_recipient_messages'
  end
end

RSpec.describe 'Api::V1::Recipients/Messages', type: :request do
  include Docs::V1::Messages::Api

  describe 'GET /recipients/{recipient_id}/messages' do
    include Docs::V1::Messages::IndexByUrl

    let(:path) { api_v1_recipient_messages_path(recipient_id: recipient.id) }

    include_examples 'retrieve_recipient_messages'
  end
end

RSpec.shared_examples 'retrieve_filtered_recipient_messages' do
  let(:recipient) { create(:user) }
  let(:sender) { create(:user) }

  context 'recipient with no messages from that sender' do
    let(:other_sender) { create(:user) }

    it 'returns empty array of messages if no messages from that sender', :dox do
      create(:message, recipient: recipient, sender: other_sender)
      get path
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ messages: [] }.to_json)
    end
  end

  context 'recipient with messages from that sender' do
    let!(:message) { create(:message, recipient: recipient, sender: sender) }
    it 'returns all messages from that sender', :dox do
      get path
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ messages: [returned_message(message)] }.to_json)
    end
  end
end

RSpec.describe 'Api::V1::Messages', type: :request do
  include Docs::V1::Messages::Api

  describe 'GET /messages?recipient_id&sender_id' do
    include Docs::V1::Messages::IndexFiltered

    let(:valid_params) { { recipient_id: recipient.id, sender_id: sender.id } }
    let(:path) { api_v1_messages_path(params: valid_params) }

    include_examples 'retrieve_filtered_recipient_messages'
  end
end

RSpec.describe 'Api::V1::Recipients/Senders/Messages', type: :request do
  include Docs::V1::Messages::Api

  describe 'GET /recipients/{recipient_id}/senders/{sender_id}/messages' do
    include Docs::V1::Messages::IndexByUrlFiltered

    let(:path) do
      api_v1_recipient_sender_messages_path(
        recipient_id: recipient.id,
        sender_id: sender.id
      )
    end

    include_examples 'retrieve_filtered_recipient_messages'
  end
end
