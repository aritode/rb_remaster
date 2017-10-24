# frozen_string_literal: true
require_relative 'lib/station'
require_relative 'lib/route'

require_relative 'lib/train'
require_relative 'lib/train/cargo_train'
require_relative 'lib/train/passenger_train'

require_relative 'lib/carriage'
require_relative 'lib/carriage/cargo_carriage'
require_relative 'lib/carriage/passenger_carriage'

require_relative 'lib/menu'

app = Menu.new
app.init
