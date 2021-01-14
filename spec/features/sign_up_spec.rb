require "rails_helper"

RSpec.describe "SignUps", type: :feature do
  it "after signing up it should redirect the user to the account setup page" do
    visit new_user_path
    fill_in "Full name", with: "John Doe"
    fill_in "Email address", with: "john@example.com"
    fill_in "Password", with: "helloworld"
    click_button "Create"

    expect(page).to have_current_path(new_app_account_setup_path)
  end
end
