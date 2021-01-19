require "rails_helper"

RSpec.describe "App::Projects", type: :request do
  describe "#create" do
    before { sign_in }

    it "creates a new project when all the fields are valid" do
      post app_projects_path, params: { project: { name: "Title", description: "Project description" } }

      expect(Project.count).to eq(1)
    end

    it "returns error if the request is invalid" do
      post app_projects_path, params: { project: attributes_for(:project).except(:plan_type, :name) }

      expect(json.dig(:errors, :name)).to be_present
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
