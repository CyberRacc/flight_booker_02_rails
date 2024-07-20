# app/services/flight_generator.rb

class FlightGenerator
  def self.generate(departure_airport_id, arrival_airport_id, departure_date)
    departure_airport = Airport.find(departure_airport_id)
    arrival_airport = Airport.find(arrival_airport_id)

    # Return an empty array if departure and arrival airports are the same
    return [] if departure_airport_id == arrival_airport_id

    flights = []

    # Generate 5 flights for the given route and date
    5.times do
      departure_time = departure_date.to_datetime + rand(6..22).hours + rand(0..59).minutes
      duration = rand(2..8).hours + rand(0..59).minutes
      arrival_time = departure_time + duration

      flights << Flight.new(
        number: "#{departure_airport.code}#{arrival_airport.code}#{rand(100..999)}",
        departure_airport: departure_airport,
        arrival_airport: arrival_airport,
        departure_time: departure_time,
        arrival_time: arrival_time,
        price: rand(100..1000).to_f
      )
    end

    flights
  end
end
