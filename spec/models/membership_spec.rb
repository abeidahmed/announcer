require "rails_helper"

RSpec.describe Membership, type: :model do
  subject(:membership) { build(:membership) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to belong_to(:project) }
  end

  describe "validations" do
    # rubocop:disable Layout/LineLength
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:project_id).case_insensitive.with_message("is already on the project team") }

    it { is_expected.to define_enum_for(:role).with_values(editor: "editor", owner: "owner").backed_by_column_of_type(:string) }
    # rubocop:enable Layout/LineLength
  end

  describe "#role" do
    it "sets the role to editor if role is not mentioned" do
      membership.role = nil

      expect(membership.role).to eq("editor")
    end

    it "sets the role to user defined var if role is mentioned" do
      membership.role = "owner"

      expect(membership.role).to eq("owner")
    end
  end

  describe "#invited" do
    it "sets the join_date to empty string if invited is set as true" do
      membership.join_date = Time.zone.now
      membership.invited = true

      expect(membership.join_date).to be_blank
    end

    it "sets the join_date to current time if invited is set as false" do
      membership.join_date = ""
      membership.invited = false

      expect(membership.join_date).to be_present
    end
  end
end
