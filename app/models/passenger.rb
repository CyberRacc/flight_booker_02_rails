class Passenger < ApplicationRecord
  belongs_to :booking
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: false
end
