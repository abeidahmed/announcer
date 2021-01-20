class Inviter
  def initialize(project, colleague:, role: "editor", invited: true)
    @project   = project
    @colleague = colleague
    @role      = role
    @invited   = invited

    invite
  end

  def user
    @user ||= User.create_with(
      full_name: full_name,
      password: SecureRandom.urlsafe_base64
    ).find_or_initialize_by(email_address: email_address)
  end

  def invite
    add_colleague_to_team
  end

  private

  attr_reader :project, :role, :invited, :colleague

  def add_colleague_to_team
    Membership.create(project: project, user: user, role: role, invited: invited)
  end

  def full_name
    colleague[:full_name]
  end

  def email_address
    colleague[:email_address].to_s.downcase
  end
end
