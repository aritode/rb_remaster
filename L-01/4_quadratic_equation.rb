print 'Введите коэффициент a:'
a = Integer(gets.chomp)

print 'Введите коэффициент b:'
b = Integer(gets.chomp)

print 'Введите коэффициент c:'
c = Integer(gets.chomp)

d = (b**2) - (4 * a * c)

puts "Дискриминант: #{d}"

if d > 0
  x1 = (-b + c) / (2 * a)
  x2 = (-b - c) / (2 * a)
  puts "X1 = #{x1}"
  puts "X2 = #{x2}"
elsif d == 0
  x = -b / (2 * a)
  puts "X1 = X2 = #{x}"
elsif d < 0
  puts 'Корней нет'
end
