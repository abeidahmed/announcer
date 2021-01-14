class User < ApplicationRecord
  has_secure_password

  before_validation :strip_email_address, :strip_full_name
  before_save :lowercase_email_address

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates(
    :email_address,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false },
  )
  validates :full_name, presence: true, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }

  private

  def strip_email_address
    self.email_address = email_address.to_s.strip
  end

  def strip_full_name
    self.full_name = full_name.to_s.strip
  end

  def lowercase_email_address
    self.email_address = email_address.to_s.downcase
  end
end
