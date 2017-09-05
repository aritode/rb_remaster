class Train
  attr_reader :speed, :carriages, :type

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def accelerate
    @speed += 20 if speed < 120
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriages += 1 if speed.zero?
  end

  def remove_carriage
    @carriages -= 1 if speed.zero? && carriages > 0
  end

  def add_route=(route)
    @route = route
    @route.stations[@train_station_index = 0].accept_train(self)
  end

  def move_next
    return if next_station.nil?
    accelerate if speed.zero?
    current_station.release_train(self)
    @train_station_index += 1
    current_station.accept_train(self)
    stop
  end

  def move_back
    return if previous_station.nil?
    accelerate if speed.zero?
    current_station.release_train(self)
    @train_station_index -= 1
    current_station.accept_train(self)
    stop
  end

  def current_station
    @route.stations[@train_station_index]
  end

  def next_station
    @route.stations[@train_station_index + 1]
  end

  def previous_station
    @route.stations[@train_station_index - 1] unless @train_station_index.zero?
  end
end
