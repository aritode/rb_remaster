require_relative 'modules/validation'

class Station
  include Validation
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  def self.all
    @@stations
  end

  def accept_train(train)
    @trains << train unless @trains.include?(train)
  end

  def release_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def each_train
    trains.each { |train| yield train } if block_given?
  end

  private

  def validate!
    if Station.all.any? { |item| item.name.downcase == @name.downcase }
      raise "Station #{@name} is already in Stations"
    end
    raise 'Station name can\'t be empty' if @name.empty?
    true
  end
end
