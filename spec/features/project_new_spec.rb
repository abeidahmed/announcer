require "rails_helper"

RSpec.describe "ProjectNews", type: :feature do
  it "creates a new project and redirects to the project show path" do
    feature_sign_in
    visit new_app_project_path
    fill_in "Project name", with: "My project"
    fill_in "Description", with: "Project description"
    click_button "Create"

    expect(page).to have_current_path(app_project_path(Project.first))
  end
end
