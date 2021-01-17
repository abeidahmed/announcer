require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  let(:user) { create(:user) }

  context "when logged in" do
    subject { described_class.new(user, Project.new) }

    it { is_expected.to permit_actions(%i[create]) }
  end

  context "when project is free" do
    let(:project) { create(:project) }
    subject { described_class.new(user, project) }

    it { is_expected.to permit_mass_assignment_of(%i[name]).for_action(:update) }
    it { is_expected.to forbid_mass_assignment_of(%i[subdomain]).for_action(:update) }
  end

  context "when project is premium" do
    let(:project) { create(:project, :premium) }
    subject { described_class.new(user, project) }

    it { is_expected.to permit_mass_assignment_of(%i[name subdomain]).for_action(:update) }
  end
end
