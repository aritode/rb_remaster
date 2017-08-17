print 'Введите первую сторону треугольника:'
a = STDIN.gets.to_f

print 'Введите вторую сторону треугольника:'
b = STDIN.gets.to_f

print 'Введите третью сторону треугольника:'
c = STDIN.gets.to_f

cathetus1, cathetus2, hypotenuse = [a, b, c].sort

if hypotenuse**2 == cathetus1**2 + cathetus2**2
  if cathetus1 == cathetus2
    puts 'Треугольник является прямоугольным и равнобедренным'
  else
    puts 'Треугольник является прямоугольным'
  end
elsif cathetus1 == cathetus2 && cathetus2 == hypotenuse
  puts 'Треугольник является равносторонним'
elsif cathetus1 == cathetus2 || cathetus1 == hypotenuse || cathetus2 == hypotenuse
  puts 'Треугольник является равнобедренным'
else
  puts 'Треугольник не является равнобедренным, равносторонним, прямоугольным'
end
