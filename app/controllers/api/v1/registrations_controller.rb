class Api::V1::RegistrationsController < ApiController
  include CreateSession
  include CommonResponse
  before_action :authenticate_user, only: %i[destroy update]

  def create
    @user = User.new(registration_params)

    if @user.save
      @token = jwt_session_create(@user.id)

      @token ? success_user_created : error_token_create
      UserMailer.send_welcome_email(@user).deliver
    else
      error_user_save
    end
  end

  def update
    if current_user.update(registration_params)
      render status: :ok, json: { message: 'Update successful',
                                  user: current_user }
    else
      # Unpermitted paramters are ignored and won't lead to an error
      render status: :unprocessable_entity, json: { errors: current_user.errors.full_message }
    end
  end

  def destroy
    current_user.destroy
    render status: :no_content, json: {}
  end

  protected

  def error_token_create
    render status: :unprocessable_entity, json: { errors: 'Error in token creation' }
  end

  def error_user_save
    render status: :unprocessable_entity, json: { errors: @user.errors.full_messages }
  end

  private

  def registration_params
    params.require(:registration).permit(:username,
                                         :password,
                                         :email,
                                         :first_name,
                                         :last_name)
  end
end
