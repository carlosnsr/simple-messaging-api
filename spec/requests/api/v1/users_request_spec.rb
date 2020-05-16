require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  include Docs::V1::Users::Api

  describe 'POST' do
    include Docs::V1::Users::Post

    let(:path) { api_v1_users_path(params: call_params) }

    # Given valid parameters, create it and return the user's id
    context 'given name' do
      let(:call_params) { { user: { name: FFaker::Name.name }} }

      it 'successfully creates a user' do
        expect{ post path }.to change{ User.count }.by(1)
        expect(response).to have_http_status(:created)
      end

      it "returns the new user's id", :dox do
        post path
        created_user = User.find_by(name: call_params[:user][:name])
        expect(response.body).to  eq({ user: { id: created_user.id }}.to_json)
      end
    end

    # If name is missing, don't create a user, and
    # return an error pointing out the missing item
    context 'if has no name' do
      let(:call_params) { { user: { not_name: 'Ummm... Hi' }} }

      it 'does not create a user' do
        expect{ post path }.not_to change{ User.count }
      end

      it 'returns an error, if name is missing', :dox do
        post path
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ errors: [
          { name: [ "can't be blank" ]}
        ]}.to_json)
      end
    end
  end
end
