require_relative 'train'
require_relative 'station'
require_relative 'route'

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
route.show

puts

route.delete(windsor)
route.show

train_1 = Train.new(10, :cargo, 20)
train_2 = Train.new(11, :cargo, 22)
train_3 = Train.new(32, :passenger, 16)


train_2.add_route = route

train_2.move_next
train_2.move_next

