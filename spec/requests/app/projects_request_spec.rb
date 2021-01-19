require "rails_helper"

RSpec.describe "App::Projects", type: :request do
  describe "#create" do
    let(:user) { create(:user) }

    before { sign_in(user) }

    context "when all the fields are valid" do
      it "creates a new project when all the fields are valid" do
        post app_projects_path, params: { project: { name: "Title", description: "hello" } }

        expect(Project.count).to eq(1)
      end

      it "adds the project creator to the team" do
        post app_projects_path, params: { project: { name: "Title", description: "hello" } }

        expect(Project.first.memberships.first.email_address).to eq(user.email_address)
      end

      it "adds the invitee to the project team if email_address is valid" do
        post app_projects_path, params: { project: { name: "Title", description: "hello", invitee_email: "hello@example.com" } }
        project = Project.first

        expect(project.memberships.count).to eq(2)
        expect(project.memberships.last.email_address).to eq("hello@example.com")
      end

      it "adds the invitee to the project team if user is member of app" do
        invitee = create(:user)
        post app_projects_path, params: { project: { name: "Title", description: "hello", invitee_email: invitee.email_address } }
        project = Project.first

        expect(project.memberships.count).to eq(2)
        expect(project.memberships.last.email_address).to eq(invitee.email_address)
      end
    end

    context "when fields are not valid" do
      it "returns error if project name is invalid" do
        post app_projects_path, params: { project: attributes_for(:project).except(:plan_type, :name) }

        expect(json.dig(:errors, :name)).to be_present
      end

      it "returns error if invitee_email is invalid" do
        post app_projects_path, params: { project: { name: "Title", description: "hello", invitee_email: "hello" } }

        expect(json.dig(:errors, :invitee_email)).to be_present
      end
    end
  end

  describe "#update" do
    let(:membership) { create(:membership, :owner) }
    let(:project) { membership.project }

    before { sign_in(membership.user) }

    it "updates the project if the fields are valid" do
      patch app_project_path(project), params: { project: { name: "hello world" } }

      expect(project.reload.name).to eq("hello world")
    end

    it "returns error if the request is invalid" do
      patch app_project_path(project), params: { project: { name: "" } }

      expect(json.dig(:errors, :name)).to be_present
    end
  end
end
