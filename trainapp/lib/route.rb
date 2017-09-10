class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete(station)
    @stations.delete(station) unless station == @stations.first || station == @stations.last
  end

  def name
    "#{@stations.first.name} - #{@stations.last.name}"
  end
end
