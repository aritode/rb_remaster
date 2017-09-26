require_relative 'modules/vendor_name'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Train
  include VendorName
  include InstanceCounter
  include Validation
  attr_reader :speed, :carriages, :type, :number, :route

  @@trains = {}

  NUMBER_FORMAT = /^(\w{3})(-\w{2})?$/
  TYPE_FORMAT = /^(CargoTrain|PassengerTrain)$/

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def accelerate
    @speed += 20 if speed < 120
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages << carriage if speed.zero?
  end

  def remove_carriage
    @carriages.pop if speed.zero? && carriages.size > 0
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

  def each_carriage
    carriages.each { |carriage| yield carriage } if block_given?
  end

  def print_info
    "Train №: #{number}, type: #{type}, carriages: #{carriages.count}"
  end

  protected

  def validate!
    raise "Train with №:#{@number} is already exist!" unless Train.find(@number).nil?
    raise 'Train number can\'t be empty' if @number.empty?
    raise 'Train must be with correct number format: ###-##' if @number !~ NUMBER_FORMAT
    raise 'Train must be correct type: CargoTrain or PassengerTrain' unless @type !~ TYPE_FORMAT
    true
  end

  private

  def move_train(index_delta)
    accelerate if speed.zero?
    current_station.release_train(self)
    @station_index += index_delta
    current_station.accept_train(self)
    stop
  end
end
