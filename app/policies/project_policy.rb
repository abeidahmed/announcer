class ProjectPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    good_project_owner?
  end

  def permitted_attributes_for_update
    if record.free?
      %i[name]
    else
      %i[name subdomain]
    end
  end
end
