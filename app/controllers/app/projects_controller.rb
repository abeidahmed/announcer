class App::ProjectsController < App::BaseController
  def index
    skip_policy_scope
  end
end
