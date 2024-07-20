class RemovePassengerIdFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :passenger_id, :integer
    remove_column :bookings, :booking_date, :datetime
    remove_column :bookings, :seat_number, :string
  end
end
