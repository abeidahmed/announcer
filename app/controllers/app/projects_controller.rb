class App::ProjectsController < App::BaseController
  def index
    skip_policy_scope
  end

  def show
    skip_authorization
  end

  def new
    @project = Project.new
    authorize @project

    render layout: "slate"
  end

  def create
    project = Project.new(project_params)
    authorize project

    if project.save
      project.memberships.create(user: current_user, role: "owner", invited: false)
      redirect_to app_project_path(project)
    else
      render json: { errors: project.errors }, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    project = Project.find(params[:id])
    authorize project

    if project.update(permitted_attributes(project))
      redirect_back_or_to edit_app_project_path(project), success: { message: show_message_after(:update) }
    else
      render json: { errors: project.errors }, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
