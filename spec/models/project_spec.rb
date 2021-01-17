require "rails_helper"

RSpec.describe Project, type: :model do
  subject(:project) { build(:project) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(255) }

    it { is_expected.to validate_presence_of(:subdomain).allow_nil }

    it { is_expected.to validate_length_of(:subdomain).is_at_most(63) }

    it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive }

    it { is_expected.to define_enum_for(:plan_type).with_values(free: "free", premium: "premium").backed_by_column_of_type(:string) } # rubocop:disable Layout/LineLength

    it "stripe project name before saving" do
      project.name = "   Hello world  "
      project.save!

      expect(project.name).to eq("Hello world")
    end
  end
end
