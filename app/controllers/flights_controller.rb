# app/controllers/flights_controller.rb

class FlightsController < ApplicationController
  def index
    @airports = Airport.all

    if search_params_present?
      @flights = FlightGenerator.generate(
        params[:departure_airport],
        params[:arrival_airport],
        Date.parse(params[:departure_date])
      )

      if @flights.empty? && params[:departure_airport] == params[:arrival_airport]
        flash.now[:alert] = "Departure and arrival airports cannot be the same."
      elsif @flights.empty?
        flash.now[:notice] = "No flights found for the selected route and date."
      end
    end
  end

  def create_flight
    @flight = Flight.new(flight_params)
    if @flight.save
      redirect_to new_booking_path(flight_id: @flight.id, passengers: params[:passengers])
    else
      flash[:alert] = "Unable to create flight. Please try again."
      redirect_to flights_path
    end
  end

  private

  def search_params_present?
    params[:departure_airport].present? &&
    params[:arrival_airport].present? &&
    params[:departure_date].present?
  end

  def flight_params
    params.require(:flight).permit(:number, :departure_airport_id, :arrival_airport_id, :departure_time, :arrival_time, :price)
  end
end
