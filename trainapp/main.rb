require_relative 'lib/train'
require_relative 'lib/station'
require_relative 'lib/route'

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

train_1 = Train.new(10, :cargo, 20)
train_2 = Train.new(11, :cargo, 22)
train_3 = Train.new(32, :passenger, 16)

puts
train_2.route = route
puts 'train_2:'
puts "Current station: #{train_2.current_station.name}"
puts "Previous station: #{train_2.previous_station.name unless train_2.previous_station.nil?}"
puts "Next station: #{train_2.next_station.name unless train_2.next_station.nil?}"

train_2.move_next
train_2.move_next
