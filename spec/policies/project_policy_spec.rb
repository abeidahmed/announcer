require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  describe "user with states" do
    subject { described_class.new(user, Project.new) }

    let(:user) { create(:user) }

    context "when not logged in" do
      include_examples "being_a_visitor"
    end

    context "when logged in" do
      it { is_expected.to permit_actions(%i[new create]) }
    end
  end

  describe "user with roles" do
    subject { described_class.new(membership.user, membership.project) }

    context "when being an owner" do
      let(:membership) { create(:membership, :owner) }

      it { is_expected.to permit_actions(%i[edit update]) }
    end

    context "when being a editor" do
      let(:membership) { create(:membership) }

      it { is_expected.to permit_actions(%i[edit]) }
      it { is_expected.to forbid_actions(%i[update]) }
    end

    context "when being an invited member" do
      let(:membership) { create(:membership, :pending_owner) }

      it { is_expected.to permit_actions(%i[edit]) }
      it { is_expected.to forbid_actions(%i[update]) }
    end
  end

  describe "project with states" do
    subject { described_class.new(user, project) }

    let(:user) { create(:user) }

    context "when project is free" do
      let(:project) { create(:project) }

      it { is_expected.to permit_mass_assignment_of(%i[name description]).for_action(:update) }

      it { is_expected.to forbid_mass_assignment_of(%i[subdomain]).for_action(:update) }
    end

    context "when project is premium" do
      let(:project) { create(:project, :premium) }

      it { is_expected.to permit_mass_assignment_of(%i[name subdomain description]).for_action(:update) }
    end
  end
end
