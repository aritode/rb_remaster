print 'Введите основание треугольника: '
# bottom  = Float(gets.chomp)
bottom = STDIN.gets.to_f

print 'Введите высоту треугольника: '
height  = STDIN.gets.to_f

area = bottom * height * 0.5

print "Площадь треугольника: #{area}"
