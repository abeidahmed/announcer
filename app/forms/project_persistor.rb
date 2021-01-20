class ProjectPersistor
  include ActiveModel::Model

  attr_accessor :name, :description, :email_address, :full_name, :current_user

  validates :name, presence: true, length: { maximum: 255 }
  validates :full_name, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }
  validates :email_address, length: { maximum: 255 }, format: { with: User::VALID_EMAIL_REGEX }, allow_blank: true
  validate :person_uniqueness

  def self.model_name
    ActiveModel::Name.new(self, nil, "Project")
  end

  def project
    @project ||= Project.create(name: name, description: description)
  end

  def user
    @user ||= User.create_with(
      full_name: full_name,
      password: SecureRandom.urlsafe_base64,
    ).find_or_initialize_by(email_address: invitee_email)
  end

  def save
    if valid?
      project.memberships.create(user: current_user, role: "owner", invited: false)
      invite_colleague

      true
    else
      false
    end
  end

  private

  def invite_colleague
    Inviter.new(project, user: user) if user.valid?
  end

  def invitee_email
    email_address.to_s.strip.downcase
  end

  def person_uniqueness
    errors.add(:person, "is already on the team") if project.memberships.exists?(user_id: user.id)
  end
end
