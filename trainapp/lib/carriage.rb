require_relative 'modules/vendor_name'
require_relative 'modules/instance_counter'

class Carriage
  include VendorName
  include InstanceCounter
  attr_reader :number

  def initialize(number)
    @number = number
    register_instance
  end
end
