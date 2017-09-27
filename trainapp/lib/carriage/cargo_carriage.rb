class CargoCarriage < Carriage
  def initialize(number, volume_max)
    @volume_max   = volume_max
    @volume_taken = 0
    @type         = self.class
    validate!
    super(number)
  end

  def take_volume(amount)
    @volume_taken += amount if amount <= available_volume && amount > 0
  end

  def available_volume
    @volume_max - @volume_taken
  end

  def to_s
    "Carriage №: #{number}, type: #{@type}, available volume: #{available_volume}, " \
    "filled volume: #{@volume_taken}"
  end

  private

  def validate!
    raise 'Maximum Volume must be greater than 0' if @volume_max.zero?
    true
  end
end
