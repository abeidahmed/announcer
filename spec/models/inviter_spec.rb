require "rails_helper"

RSpec.describe Inviter, type: :model do
  let(:project) { create(:project) }

  describe "#initialize" do
    let(:inviter) { Inviter.new(project, email_address: "x@tu.com") }

    it "sets the project" do
      expect(inviter.instance_variable_get(:@project)).to eq(project)
    end

    it "sets the email_address to the described email_address" do
      expect(inviter.instance_variable_get(:@email_address)).to eq("x@tu.com")
    end

    it "sets the role to editor" do
      expect(inviter.instance_variable_get(:@role)).to eq("editor")
    end

    it "sets the invited to false" do
      expect(inviter.instance_variable_get(:@invited)).to eq(false)
    end
  end

  describe "#user" do
    it "finds the user" do
      user = create(:user)
      inviter = Inviter.new(project, email_address: user.email_address)

      expect(inviter.user).to eq(user)
    end

    it "creates a new user if the user is not found" do
      inviter = Inviter.new(project, email_address: "hello@ex.com")

      expect(User.first.email_address).to eq("hello@ex.com")
    end
  end
end

