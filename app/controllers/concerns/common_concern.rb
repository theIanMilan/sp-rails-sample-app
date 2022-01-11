# frozen_string_literal: true

# Includes common renders as methods
module CommonResponse
  def success_user_created
    response.headers['Authorization'] = "Bearer #{@token}"
    render status: :created, json: { Authorization: "Bearer #{@token}",
                                     user: @user }
  end
end
