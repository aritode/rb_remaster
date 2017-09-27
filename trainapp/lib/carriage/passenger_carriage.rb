class PassengerCarriage < Carriage
  def initialize(number, total_seats)
    @total_seats = total_seats
    @reserved_seats = 0
    validate!
    super(number)
  end

  def take_seat
    @reserved_seats += 1 if @reserved_seats < @total_seats
  end

  def seats_available
    @total_seats - @reserved_seats
  end

  def to_s
    "Carriage №: #{number}, type: #{self.class}, available seats: #{seats_available}, "  \
    "reserved seats: #{@reserved_seats}"
  end

  private

  def validate!
    raise 'Maximum number of Seats must be greater than 0' if @total_seats.zero?
    true
  end
end
