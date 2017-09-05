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
    @carriages += 1 if self.speed.zero?
  end

  def remove_carriage
    @carriages -= 1 if self.speed.zero?
  end

  def add_route=(route)
    @train_route = route
    @train_station_index = 0
  end

  def move_next
    return if @train_station_index == @train_route.stations.length - 1
    accelerate if speed.zero?
    @train_route.stations[@train_station_index].release_train(self)
    @train_station_index += 1
    @train_route.stations[@train_station_index].accept_train(self)
    self.stop
  end

  def move_back
    return if @train_station_index == 0
    accelerate if speed.zero?
    @train_route.stations[@train_station_index].release_train(self)
    @train_station_index -= 1
    @train_route.stations[@train_station_index].accept_train(self)
    self.stop
  end

  def show_current_station
    @train_route.stations[@train_station_index].name
  end

  def show_next_station
    if @train_station_index < @train_route.stations.length - 1
      @train_route.stations[@train_station_index + 1].name
    else
      puts 'Вы находитесь на последней станции в маршруте'
      @train_route.stations[@train_station_index].name
    end
  end

  def show_previous_station
    if @train_station_index - 1 >= 0
      @train_route.stations[@train_station_index - 1].name
    else
      puts 'Вы находитесь на первой станции в маршруте'
      @train_route.stations[@train_station_index].name
    end
  end
end

