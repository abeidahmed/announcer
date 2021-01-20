class Inviter
  def initialize(project, user:, role: "editor", invited: true)
    @project = project
    @user    = user
    @role    = role
    @invited = invited

    invite
  end

  def invite
    add_colleague_to_team
  end

  private

  attr_reader :project, :role, :invited, :user

  def add_colleague_to_team
    Membership.create(project: project, user: user, role: role, invited: invited)
  end
end
