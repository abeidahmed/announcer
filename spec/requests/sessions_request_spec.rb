require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "#create" do
    it "signs in the user if the request is valid" do
      post sessions_path, params: { email_address: user.email_address, password: user.password }

      expect(cookies[:auth_token]).to eq(user.auth_token)
    end

    it "returns an error if the request is invalid" do
      post sessions_path, params: { email_address: "", password: "helloworld" }

      expect(json.dig(:errors, :invalid)).to be_present
    end
  end

  describe "#destroy" do
    it "will delete the auth_token from the cookie" do
      sign_in(user)
      delete session_path("current_user")

      expect(cookies[:auth_token]).to be_blank
    end
  end
end
