require 'rails_helper'

describe 'when signing up as a new user', type: :request do
  context 'with valid params' do
    before do
      post '/api/sign_up',
           params: { registration: { username: 'HelloWorld', password: 'password1234', email: 'example@example.com',
                                     first_name: 'Dee', last_name: 'Test' } }
    end

    it 'returns a valid JWT' do
      expect(json_response['Authorization']).to include('Bearer')
    end

    it "returns the user's username" do
      expect(json_response['user']['username']).to eq(controller.params[:registration][:username])
    end

    it "returns the user's bcrypt's encrypted password" do
      expect(json_response['user']['password_digest']).to_not eq(nil)
    end

    it "returns the user's email" do
      expect(json_response['user']['email']).to eq(controller.params[:registration][:email])
    end

    it "returns the user's first_name" do
      expect(json_response['user']['first_name']).to eq(controller.params[:registration][:first_name])
    end

    it "returns the user's last_name" do
      expect(json_response['user']['last_name']).to eq(controller.params[:registration][:last_name])
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end

  # context 'with invalid params' do
  #   before do
  #     post '/api/sign_up',
  #          params: { registration: { username: 'HelloWorld', password: 'password1234', email: 1,
  #                                    first_name: 'Dee', last_name: 'Test' } }
  #   end

  #   it 'returns a JSON with errors as a key' do
  #     expect(json_response['errors']).to_not eq(nil)
  #   end

  #   it 'returns a status of unprocessable_entity' do
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end
end
