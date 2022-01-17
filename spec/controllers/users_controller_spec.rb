require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'with proper params' do
    let!(:user) { create(:user) }

    def params
      { users: { first_name: 'AAA', last_name: 'ZZZ' } }
    end

    it "updates a user's first and last name" do
      auth_patch("/api/users/#{user.id}", params)
      expect(json_response)['user']['first_name'].to eq(params)[:user][:first_name]
      expect(json_response)['user']['last_name'].to eq(params)[:user][:last_name]
    end
  end
end
