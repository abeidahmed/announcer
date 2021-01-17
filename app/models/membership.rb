class Membership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum role: { editor: "editor", owner: "owner" }

  validates :user_id, uniqueness: { scope: :project_id, case_sensitive: false, message: "is already on the project team" } # rubocop:disable Layout/LineLength
end
