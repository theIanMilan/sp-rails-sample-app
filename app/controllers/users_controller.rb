class UsersController < ApplicationController
  include CreateSession
  include CommonResponse
  before_action :authenticate_user, only: %i[update]

  def update
    full_name = Users::Processor.new.full_name(current_user)

    if current_user.update(users_params)
      success_message('User successfully updated')
    else
      object_error(current_user)
    end
  end

  private

  def users_params
    params.require(:users).permit(:first_name,
                                  :last_name)
  end
end
