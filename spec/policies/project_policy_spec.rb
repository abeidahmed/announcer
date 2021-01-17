require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  subject { described_class.new(user, Project.new) }

  let(:user) { create(:user) }

  include_examples "being_a_visitor"

  context "when logged in" do
    it { is_expected.to permit_actions(%i[create]) }
  end
end
