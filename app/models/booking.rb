# app/models/booking.rb
require 'rqrcode'

class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, dependent: :destroy
  accepts_nested_attributes_for :passengers

  before_create :generate_ticket_number

  validates_presence_of :passengers

  def generate_ticket_number
    self.ticket_number = "TKT#{SecureRandom.hex(4).upcase}"
  end

  def generate_qr_code
    qr = RQRCode::QRCode.new(ticket_info)
    qr.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    )
  end

  private

  def ticket_info
    "Booking ID: #{id}\nTicket: #{ticket_number}\nFlight: #{flight.number}\nDate: #{flight.departure_time.strftime('%B %d, %Y')}"
  end
end
