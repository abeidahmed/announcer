require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  let(:user) { create(:user) }

  context "when logged in" do
    subject { described_class.new(user, Project.new) }

    it { is_expected.to permit_actions(%i[create]) }
  end

  context "when project is free" do
    subject { described_class.new(user, project) }

    let(:project) { create(:project) }

    it { is_expected.to permit_mass_assignment_of(%i[name]).for_action(:update) }
    it { is_expected.to forbid_mass_assignment_of(%i[subdomain]).for_action(:update) }
  end

  context "when project is premium" do
    subject { described_class.new(user, project) }

    let(:project) { create(:project, :premium) }

    it { is_expected.to permit_mass_assignment_of(%i[name subdomain]).for_action(:update) }
  end
end
