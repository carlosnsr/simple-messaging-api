# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  describe 'POST' do
    let(:sender) { create(:user) }
    let(:recipient) { create(:user) }
    let(:text) { FFaker::HipsterIpsum.phrase }
    let(:valid_params) do
      {
        message: {
          sender_id: sender.id,
          recipient_id: recipient.id,
          text: text
        }
      }
    end

    # Given valid parameters, create it and return the message's id and timestamp
    context 'given a sender, a recipient, and text' do
      it 'is successful' do
        post messages_path(params: valid_params)
        expect(response).to have_http_status(:created)
      end

      it 'saves creates the message' do
        expect { post messages_path(params: valid_params) }
          .to change { Message.count }.by(1)
      end

      it 'returns the message id and timestamp' do
        post messages_path(params: valid_params)
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
    context 'if any required parameter is missing' do
      around(:example) do |example|
        expect(&example).not_to change { Message.count }
      end

      def clone_without_key(key, orig)
        { message: orig[:message].reject { |k, _v| k == key } }
      end

      context 'no recipient_id' do
        let(:params_no_recipient) { clone_without_key(:recipient_id, valid_params) }

        it 'returns an error' do
          post messages_path(params: params_no_recipient)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq(
            { error: 'param is missing or the value is empty: recipient_id' }.to_json
          )
        end
      end

      context 'no sender_id' do
        let(:params_no_sender) { clone_without_key(:sender_id, valid_params) }

        it 'returns an error' do
          post messages_path(params: params_no_sender)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq(
            { error: 'param is missing or the value is empty: sender_id' }.to_json
          )
        end
      end

      context 'no text' do
        let(:params_no_text) { clone_without_key(:text, valid_params) }

        it 'returns an error' do
          post messages_path(params: params_no_text)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq(
            { error: 'param is missing or the value is empty: text' }.to_json
          )
        end
      end
    end
  end
end
