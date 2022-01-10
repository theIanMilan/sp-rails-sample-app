class Api::V1::SessionsController < ApiController
  include CreateSession

  before_action :authenticate_user, only: %i[validate_token destroy]

  def create
    return error_insufficient_params unless params[:username].present? && params[:password].present?

    @user = User.find_by(username: params[:username])
    return error_invalid_credentials unless @user

    return error_invalid_credentials unless @user.authenticate(params[:password])

    @token = jwt_session_create(@user.id)
    if @token
      @token = "Bearer #{@token}"
      success_session_created
    else
      error_token_create
    end
  end

  def validate_token
    # Extra method used by a logged-in user coming after sometime
    @token = request.headers['Authorization']
    @user = current_user
    success_valid_token
  end

  def destroy
    headers = request.headers['Authorization'].split(' ').last
    session = Session.find_by(token: JsonWebToken.decode(headers)[:token])
    session.close
    success_session_destroy
  end

  protected

  def success_valid_token
    response.headers['Authorization'] = "Bearer #{@token}"
    render status: :ok, json: { Authorization: @token, user: @user }
  end

  def success_session_created
    response.headers['Authorization'] = "Bearer #{@token}"
    render status: :created, json: { Authorization: @token, user: @user }
  end

  def success_session_destroy
    render status: :no_content, json: {}
  end

  def error_insufficient_params
    render status: :unprocessable_entity, json: { errors: 'Insufficient params' }
  end

  def error_invalid_credentials
    render status: :unauthorized, json: { errors: 'Invalid credentials' }
  end

  def error_token_create
    render status: :unprocessable_entity, json: { errors: 'Token not created' }
  end
end
