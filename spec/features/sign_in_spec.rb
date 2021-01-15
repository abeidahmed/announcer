require "rails_helper"

RSpec.describe "SignIns", type: :feature do
  it "takes the user to sign up page if the Sign up link is clicked" do
    visit new_session_path
    click_link "Sign up"

    expect(page).to have_current_path(new_user_path)
  end
end
