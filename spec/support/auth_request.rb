%i[get patch put post delete].each do |method|
  define_method "auth_#{method}" do |path, params = {}, headers = {}|
    session = current_user.sessions.build
    _headers = {}
    _headers.merge!('Authorization' => "Bearer #{JsonWebToken.encode(user_id: current_user.id, token: session.token)}")
    send(method, path, params: params, headers: _headers)
  end
end
