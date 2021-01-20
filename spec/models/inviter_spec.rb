require "rails_helper"

RSpec.describe Inviter, type: :model do
  let(:project) { create(:project) }

  describe "#initialize" do
    let(:inviter) { Inviter.new(project, colleague: { email_address: "x@tu.com", full_name: "hello" }) }

    it "sets the project" do
      expect(inviter.instance_variable_get(:@project)).to eq(project)
    end

    it "sets the @colleague to user hash" do
      expect(inviter.instance_variable_get(:@colleague)).to eq({ email_address: "x@tu.com", full_name: "hello" })
    end

    it "sets the role to editor" do
      expect(inviter.instance_variable_get(:@role)).to eq("editor")
    end

    it "sets the invited to false" do
      expect(inviter.instance_variable_get(:@invited)).to eq(true)
    end
  end

  describe "#user" do
    it "finds the user" do
      user = create(:user)
      inviter = Inviter.new(project, colleague: { email_address: user.email_address.upcase, full_name: user.full_name })

      expect(inviter.user).to eq(user)
    end

    it "creates a new user if the user is not found" do
      inviter = Inviter.new(project, colleague: { email_address: "hello@ex.com", full_name: "hello" })

      expect(User.first.email_address).to eq("hello@ex.com")
      expect(User.first.full_name).to eq("hello")
    end
  end

  describe "#invite" do
    let(:user) { create(:user) }

    before do
      Inviter.new(project, colleague: { email_address: user.email_address, full_name: user.full_name })
    end

    it "adds the user to the project membership" do
      expect(Membership.first.email_address).to eq(user.email_address)
    end

    it "adds the user as invited" do
      expect(Membership.first.join_date).to be_blank
    end

    it "adds the user as an editor" do
      expect(Membership.first.role).to eq("editor")
    end
  end
end

