# frozen_string_literal: true
require_relative 'modules/vendor_name'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Carriage
  include VendorName
  include InstanceCounter
  include Validation
  attr_reader :number

  validate :number, :presence

  TYPE_FORMAT = /^(CargoTrain|PassengerTrain)$/

  def initialize(number)
    @number = number
    validate!
    register_instance
  end

  protected

  def validate!
    raise 'Train must be correct type: CargoTrain or PassengerTrain' unless @type !~ TYPE_FORMAT
    super
  end
end
