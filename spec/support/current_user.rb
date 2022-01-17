def current_user
  @current_user ||= User.first || FactoryBot.create(:user, password: 'Abcd1234')
end
