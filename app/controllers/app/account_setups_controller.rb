class App::AccountSetupsController < App::BaseController
  def new
    skip_authorization
  end
end
