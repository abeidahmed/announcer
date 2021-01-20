require "rails_helper"

RSpec.describe Inviter, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  describe "#initialize" do
    let(:inviter) { described_class.new(project, user: user) }

    it "sets the project" do
      expect(inviter.instance_variable_get(:@project)).to eq(project)
    end

    it "sets the @user" do
      expect(inviter.instance_variable_get(:@user)).to eq(user)
    end

    it "sets the role to editor" do
      expect(inviter.instance_variable_get(:@role)).to eq("editor")
    end

    it "sets the invited to false" do
      expect(inviter.instance_variable_get(:@invited)).to eq(true)
    end
  end

  describe "#invite" do
    let(:user) { create(:user) }

    before do
      described_class.new(project, user: user)
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
