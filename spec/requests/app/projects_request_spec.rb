require "rails_helper"

RSpec.describe "App::Projects", type: :request do
  describe "#create" do
    let(:user) { create(:user) }

    before { sign_in(user) }

    context "when all the fields are valid" do
      it "creates a new project" do
        post app_projects_path, params: { project: { name: "Title", description: "hello" } }

        expect(Project.count).to eq(1)
      end

      it "adds the project creator to the team" do
        post app_projects_path, params: { project: { name: "Title", description: "hello" } }
        membership = Project.first.memberships.first

        expect(membership.email_address).to eq(user.email_address)
        expect(membership.full_name).to eq(user.full_name)
        expect(membership.role).to eq("owner")
        expect(membership.join_date).to be_present
      end
    end

    it "returns error if project name is invalid" do
      post app_projects_path, params: { project: attributes_for(:project).except(:plan_type, :name) }

      expect(json.dig(:errors, :name)).to be_present
    end
  end

  describe "#update" do
    let(:membership) { create(:membership, :owner) }
    let(:project) { membership.project }

    before { sign_in(membership.user) }

    it "updates the project if the fields are valid" do
      patch app_project_path(project), params: { project: { name: "Project name", description: "Description" } }

      project.reload

      expect(project.name).to eq("Project name")
      expect(project.description).to eq("Description")
    end

    it "returns error if the request is invalid" do
      patch app_project_path(project), params: { project: { name: "" } }

      expect(json.dig(:errors, :name)).to be_present
    end
  end
end
