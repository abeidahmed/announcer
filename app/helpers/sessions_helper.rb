module SessionsHelper
  def sign_in(user)
    cookies.permanent[:auth_token] = user.auth_token
  end
end
