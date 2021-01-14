require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it { is_expected.to have_secure_password }

    it { is_expected.to validate_presence_of(:email_address) }

    it { is_expected.to validate_uniqueness_of(:email_address).case_insensitive }

    it { is_expected.to validate_length_of(:email_address).is_at_most(255) }

    it { is_expected.to allow_value("johndoe@example.com", "johjn@exa.co.in").for(:email_address) }

    it { is_expected.not_to allow_value("johndoeexample.com", "johjn@exa").for(:email_address) }

    it { is_expected.to validate_presence_of(:full_name) }

    it { is_expected.to validate_length_of(:full_name).is_at_most(255) }

    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    it "lowercases email_address before saving" do
      email_address = "hello@example.com"
      user.email_address = email_address.upcase
      user.save!

      expect(user.email_address).to eq(email_address)
    end

    it "strips the email_address before validation" do
      user.email_address = "   hello@example.com "
      user.save!

      expect(user.email_address).to eq("hello@example.com")
    end

    it "strips the full_name before validation" do
      user.full_name = "  John Doe Howard "
      user.save!

      expect(user.full_name).to eq("John Doe Howard")
    end
  end
end
