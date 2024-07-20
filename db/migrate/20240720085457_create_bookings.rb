class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :flight, null: false, foreign_key: true
      t.references :passenger, null: false, foreign_key: true
      t.datetime :booking_date, null: false
      t.string :seat_number

      t.timestamps
    end
  end
end
