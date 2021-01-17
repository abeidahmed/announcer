class ProjectPolicy < ApplicationPolicy
  def create?
    user
  end
end
