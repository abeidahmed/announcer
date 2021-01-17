class Project < ApplicationRecord
  before_save :trim_project_name

  enum plan_type: { free: "free", premium: "premium" }

  validates :name, presence: true, length: { maximum: 255 }
  validates :subdomain, presence: true, allow_nil: true, uniqueness: { case_sensitive: false }, length: { maximum: 63 }

  private

  def trim_project_name
    self.name = name.to_s.strip
  end
end
