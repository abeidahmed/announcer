class ProjectPolicy < ApplicationPolicy
  def create?
    user
  end

  def edit?
    allow_but_redirect
  end

  def update?
    good_project_owner?
  end

  def permitted_attributes_for_update
    if record.free?
      %i[name description]
    else
      %i[name subdomain description]
    end
  end
end
