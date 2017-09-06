require_relative 'lib/station'
require_relative 'lib/route'

require_relative 'lib/train'
require_relative 'lib/train/cargo_train'
require_relative 'lib/train/passenger_train'

require_relative 'lib/carriage'
require_relative 'lib/carriage/cargo_carriage'
require_relative 'lib/carriage/passenger_carriage'

alaska = Station.new("Alaska")
alabama = Station.new "Alabama"

route = Route.new(alaska, alabama)

nortwich = Station.new("Nortwich")
route.add(nortwich)
route.add(nortwich)
route.add(nortwich)

windsor = Station.new("Windsor")
route.add(windsor)

route.delete(alabama)
route.delete(alaska)
route.stations.each { |station| puts station.name }

puts

route.delete(windsor)
route.stations.each { |station| puts station.name }

train1 = PassengerTrain.new(121)

# train_1 = CargoTrain.new(10, :cargo, 20)
# train_2 = CargoTrain.new(11, :cargo, 22)
train_2 = CargoTrain.new(11)
# train_3 = PassengerTrain.new(32, :passenger, 16)

puts
train_2.route = route
puts 'train_2:'
puts "Current station: #{train_2.current_station.name}"
puts "Previous station: #{train_2.previous_station.name unless train_2.previous_station.nil?}"
puts "Next station: #{train_2.next_station.name unless train_2.next_station.nil?}"

train_2.move_next
train_2.move_next
