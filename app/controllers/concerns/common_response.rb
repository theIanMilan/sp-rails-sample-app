# frozen_string_literal: true

# Includes common renders as methods
module CommonResponse
  def success_message(message)
    response.headers['Authorization'] = "Bearer #{@token}"
    render status: :created, json: { message: message,
                                     Authorization: "Bearer #{@token}",
                                     user: @user }
  end

  def error_message(_message = 'Error encountered')
    render status: :unprocessable_entity, json: { errors: message }
  end

  def object_error(obj)
    render status: :unprocessable_entity, json: { errors: obj.errors.full_messages }
  end
end
