class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper

  add_flash_types :success
end
