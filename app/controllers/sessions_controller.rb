class SessionsController < ApplicationController
  def create
    auth = Authentication.new(params)

    if auth.authenticated?
      sign_in(auth.user)
    else
      render json: { errors: { invalid: ["credentials"] } }, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user = nil
    sign_out_user
  end
end
