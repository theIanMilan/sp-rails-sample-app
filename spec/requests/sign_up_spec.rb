require 'rails_helper'

describe 'when signing up as a new user', type: :request do
  context 'with valid params' do
    before do
      post '/api/sign_up',
           params: { registration: { username: 'HelloWorld', password: 'password1234', email: 'example@example.com',
                                     first_name: 'Dee', last_name: 'Test' } }
    end

    it 'returns a valid JWT' do
      expect(JSON.parse(response.body)['Authorization']).to include('Bearer')
    end

    it "returns the user's username" do
      expect(JSON.parse(response.body)['user']['username']).to eq(controller.params[:registration][:username])
    end

    it "returns the user's bcrypt's encrypted password" do
      expect(JSON.parse(response.body)['user']['password_digest']).to_not eq(nil)
    end

    it "returns the user's email" do
      expect(JSON.parse(response.body)['user']['email']).to eq(controller.params[:registration][:email])
    end

    it "returns the user's first_name" do
      expect(JSON.parse(response.body)['user']['first_name']).to eq(controller.params[:registration][:first_name])
    end

    it "returns the user's last_name" do
      expect(JSON.parse(response.body)['user']['last_name']).to eq(controller.params[:registration][:last_name])
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
  #     expect(JSON.parse(response.body)['errors']).to_not eq(nil)
  #   end

  #   it 'returns a status of unprocessable_entity' do
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end
end
