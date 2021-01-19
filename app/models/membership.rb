class Membership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum role: { editor: "editor", owner: "owner" }

  validates :user_id, uniqueness: { scope: :project_id, case_sensitive: false, message: "is already on the project team" } # rubocop:disable Layout/LineLength

  def role=(role_type)
    default_role = role_type.presence || "editor"
    super(default_role)
  end

  def invited=(value)
    self.join_date = value ? "" : Time.zone.now
  end
end
