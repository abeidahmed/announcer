class App::ProjectsController < App::BaseController
  def index
    skip_policy_scope
  end

  def show
    skip_authorization
  end

  def create
    project = Project.new(project_params)
    authorize project

    if project.save
      # do something
    else
      render json: { errors: project.errors }, status: :unprocessable_entity
    end
  end

  def edit
    skip_authorization
  end

  def update
    project = Project.find(params[:id])
    authorize project

    if project.update(permitted_attributes(project))
      # do something
    else
      render json: { errors: project.errors }, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :subdomain)
  end
end
