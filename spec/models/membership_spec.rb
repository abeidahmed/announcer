require "rails_helper"

RSpec.describe Membership, type: :model do
  subject(:membership) { build(:membership) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to belong_to(:project) }
  end
end
