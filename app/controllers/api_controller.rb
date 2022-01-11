# frozen_string_literal: true

class ApiController < ActionController::Base
  include AuthenticateRequest
  protect_from_forgery with: :null_session
end
