class User < ApplicationRecord
  has_secure_password

  validates :name, :email, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  def is_admin?
    role == "admin"
  end
end
