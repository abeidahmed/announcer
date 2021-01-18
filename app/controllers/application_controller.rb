class ApplicationController < ActionController::Base
  include MessagesHelper
  include Pundit
  include SessionsHelper

  add_flash_types :success

  def redirect_back_or_to(fallback_location, **args)
    redirect_back fallback_location: fallback_location, **args
  end
end
