class App::BaseController < ApplicationController
  before_action :authenticate_user

  # rubocop:disable Rails/LexicallyScopedActionFilter, Lint/RedundantCopDisableDirective
  after_action :verify_authorized, except: %i[index]
  after_action :verify_policy_scoped, only: %i[index]
  # rubocop:enable Rails/LexicallyScopedActionFilter, Lint/RedundantCopDisableDirective

  private

  def authenticate_user
    redirect_to new_session_path, alert: { message: "Please signup or login to continue" } unless user_signed_in?
  end
end
