class Inviter
  def initialize(project, email_address:, role: "editor", invited: false)
    @project       = project
    @email_address = email_address
    @role          = role
    @invited       = invited

    invite
  end

  def user
    @user ||= User.create_with(
      full_name: "hello",
      password: SecureRandom.urlsafe_base64
    ).find_or_initialize_by(email_address: email_address)
  end

  def invite
    add_colleague_to_team
  end

  private

  attr_reader :project, :email_address, :role, :invited

  def add_colleague_to_team
    Membership.create(project: project, user: user, role: role, invited: invited)
  end
end
