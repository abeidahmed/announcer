require "rails_helper"

RSpec.describe "ProjectEdits", type: :feature do
  it "displays a success notification after updating the project" do
    membership = create(:membership, :owner)
    user = membership.user
    project = membership.project
    feature_sign_in(user)
    visit edit_app_project_path(project)

    within "#project-setting-form" do
      fill_in "Project name", with: "Update project"
      fill_in "Subdomain", with: "hello"
      click_button "Save changes"
    end

    expect(page).to have_text("your changes")
  end
end
