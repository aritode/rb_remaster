require_relative 'modules/validation'

class Route
  include Validation
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
  end

  def add(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete(station)
    @stations.delete(station) unless station == @stations.first || station == @stations.last
  end

  def to_s
    "Route: #{@stations.first.name} - #{@stations.last.name}"
  end

  private

  def validate!
    raise 'Incorrect First Station type' unless @stations.first.instance_of?(Station)
    raise 'Incorrect Last Station type' unless @stations.last.instance_of?(Station)
    raise 'Last Station can\'t be the same as First Station' if @stations.first == @stations.last
    true
  end
end
