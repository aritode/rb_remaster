require_relative 'modules/vendor_name'

class Carriage
  include VendorName
  attr_reader :number

  def initialize(number)
    @number = number
  end
end
