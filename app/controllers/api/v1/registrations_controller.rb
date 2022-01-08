class Api::V1::RegistrationsController < ApiController
  include CreateSession
  before_action :authenticate_user, only: :destroy

  def create
    @user = User.new(registration_params)

    if @user.save
      @token = jwt_session_create(@user.id)

      @token ? success_user_created : error_token_create
    else
      error_user_save
    end
  end

  def destroy
    current_user.destroy
    render status: :no_content, json: {}
  end

  protected

  def success_user_created
    response.headers['Authorization'] = "Bearer #{@token}"
    render status: :created, json: { Authorization: "Bearer #{@token}",
                                     user: @user }
  end

  def error_token_create
    render status: :unprocessable_entity, json: { errors: 'Error in token creation' }
  end

  def error_user_save
    render status: :unprocessable_entity, json: { errors: @user.errors.full_messages }
  end

  private

  def registration_params
    params.permit(:username,
                  :password,
                  :email,
                  :first_name,
                  :last_name)
  end
end
