class CargoCarriage < Carriage
  attr_reader :volume

  def initialize(number, volume_max)
    @volume_max = volume_max
    @volume = 0
    validate!
    super(number)
  end

  def take_volume(amount)
    @volume += amount if amount <= available_volume && amount > 0
  end

  def available_volume
    @volume_max - volume
  end

  private

  def validate!
    raise 'Maximum Volume must be greater than 0' if @volume_max.zero?
    true
  end
end
