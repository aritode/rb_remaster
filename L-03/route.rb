class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
  end

  def add(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete(station)
    @stations.delete_if { |st| st == station && station != @first_station && station != @last_station }
  end

  def show
    @stations.each { |station| print "#{station.name} " }
  end
end
