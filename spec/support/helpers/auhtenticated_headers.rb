module AuthenticatedHeaders
  def authenticated_headers(user)
    default_headers.merge("Authorization": user.auth_token)
  end
end 