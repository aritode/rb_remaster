class PassengerCarriage < Carriage
  MAX_SEATS = 56
  attr_reader :reserved_seats

  def initialize(number, total_seats = MAX_SEATS)
    @total_seats = total_seats
    @reserved_seats = 0
    super(number)
  end

  def take_seat
    @reserved_seats += 1 if reserved_seats < @total_seats
  end

  def seats_available
    @total_seats - reserved_seats
  end
end
