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

  def route=(route)
    @route         = route
    @station_index = 0
    current_station.accept_train(self)
  end

  def move_next
    return if next_station.nil?
    move_train(1)
  end

  def move_back
    return if previous_station.nil?
    move_train(-1)
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    @route.stations[@station_index - 1] unless @station_index.zero?
  end

  def move_train(index_delta)
    accelerate if speed.zero?
    current_station.release_train(self)
    @station_index += index_delta
    current_station.accept_train(self)
    stop
  end
end
