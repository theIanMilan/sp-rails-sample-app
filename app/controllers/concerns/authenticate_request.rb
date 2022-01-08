module AuthenticateRequest
  extend ActiveSupport::Concern
  require 'json_web_token'

  def authenticate_user
    return render status: :unauthorized, json: { errors: 'Unauthenticated user' } unless current_user
  end

  def current_user
    @current_user = nil
    if decoded_token
      data = decoded_token
      user = User.find(data[:user_id])
      session = Session.search(data[:user_id], data[:token])

      if user && session && !session.late?
        session.used
        @current_user ||= user
      end
    end
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      header = header.split(' ').last
      begin
        @decoded_token ||= JsonWebToken.decode(header)
      rescue StandardError => e
        render json: { error: e.message }, status: :unauthorized
      end
    end
  end
end
