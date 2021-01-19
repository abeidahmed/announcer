class ProjectPersistor
  include ActiveModel::Model

  attr_accessor :name, :description, :invitee_email, :current_user

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }
  validates :invitee_email, length: { maximum: 255 }, format: { with: User::VALID_EMAIL_REGEX }, allow_blank: true

  def self.model_name
    ActiveModel::Name.new(self, nil, "Project")
  end

  def project
    @project ||= Project.create(name: name, description: description)
  end

  def invite_invitee
    @user ||= User.create_with(
      full_name: "hello",
      password: SecureRandom.urlsafe_base64
    ).find_or_initialize_by(email_address: invitee_email)
  end

  def save
    if valid?
      project.memberships.create(user: current_user, role: "owner")
      invite_colleague

      true
    else
      false
    end
  end

  private

  def invite_colleague
    project.memberships.create(user: invite_invitee, invited: true) if invite_invitee.valid?
  end
end
