class App::ProjectsController < App::BaseController
  def index
    skip_policy_scope
  end

  def show
    skip_authorization
  end
end
