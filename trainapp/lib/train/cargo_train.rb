# frozen_string_literal: true
class CargoTrain < Train
  def initialize(number)
    super(number, self.class)
  end

  def add_carriage(carriage)
    super if carriage.instance_of?(CargoCarriage)
  end
end
