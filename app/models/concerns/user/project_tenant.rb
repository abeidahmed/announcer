class User
  module ProjectTenant
    def project_membership?(project)
      memberships.exists?(project_id: project)
    end

    def project_invite_accepted?(project)
      find_membership(project).join_date?
    end

    def project_invite_pending?(project)
      !project_invite_accepted?(project)
    end

    def project_owner?(project)
      find_membership(project).owner?
    end

    def find_membership(project)
      memberships.find_by(project_id: project)
    end
  end
end
