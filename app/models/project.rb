class Project < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  before_save :trim_project_name

  enum plan_type: { free: "free", premium: "premium" }

  validates :name, presence: true, length: { maximum: 255 }
  validates :subdomain, uniqueness: { case_sensitive: false, allow_nil: true }, length: { maximum: 63 }
  validates :description, length: { maximum: 500 }

  # TODO: Add subdomain regex for valid characters

  private

  def trim_project_name
    self.name = name.to_s.strip
  end
end
