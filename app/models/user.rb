class User < ApplicationRecord
  include Users::PropertiesManager

  validates :name, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone_number, presence: true
end
