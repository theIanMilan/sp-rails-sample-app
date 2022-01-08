class Api::V1::RegistrationsController < ApiController
  include CreateSession

  def create
    @user = User.new(registration_params)

    if @user.save
      exp = 1.day.from_now
      @token = JsonWebToken.encode({ user_id: @user.id }, exp)

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
    render status: :created, json: { Authorization: @token,
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
