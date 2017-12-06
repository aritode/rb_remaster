# frozen_string_literal: true
require_relative '../modules/validation'

class PassengerTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, self.class)
  end

  def add_carriage(carriage)
    super if carriage.instance_of?(PassengerCarriage)
  end
end
