require "rails_helper"

RSpec.describe "SignIns", type: :feature do
  context "when the user enters valid credentials" do
    let(:user) { create(:user) }

    before { feature_sign_in(user) }

    it "redirects the user to project index page after successful sign in" do
      expect(page).to have_current_path(app_projects_path)
    end

    it "shows an success notification" do
      expect(page).to have_text("signed")
    end
  end

  it "takes the user to sign up page if the Sign up link is clicked" do
    visit new_session_path
    click_link "Sign up"

    expect(page).to have_current_path(new_user_path)
  end
end
