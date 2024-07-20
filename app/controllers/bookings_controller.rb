class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    @booking.generate_ticket_number if @booking.ticket_number.nil?
    @booking.save if @booking.changed?
  end

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.build
    params[:passengers].to_i.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      @flight = @booking.flight
      flash.now[:alert] = 'There was an error creating your booking. Please check the form and try again.'
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:first_name, :last_name, :email])
  end
end
