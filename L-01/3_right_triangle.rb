print 'Введите первую сторону треугольника:'
a = Integer(gets.chomp)

print 'Введите вторую сторону треугольника:'
b = Integer(gets.chomp)

print 'Введите третью сторону треугольника:'
c = Integer(gets.chomp)

triangle = [a, b, c].sort

if triangle[2]**2 == triangle[1]**2 + triangle[0]**2
  puts 'Треугольник является прямоугольным!'
elsif a == b && b == c
  puts 'Треугольник является равносторонним'
elsif a == b || a == c || b == c
  puts 'Треугольник является равнобедренным'
else
  puts 'Треугольник не является равнобедренным, равносторонним, прямоугольным'
end
