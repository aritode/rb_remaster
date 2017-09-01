puts 'Введите число: '
day = gets.chomp.to_i

puts 'Введите месяц: '
month = gets.chomp.to_i

puts 'Введите год: '
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[1] = 29 if year % 400 == 0 || ( year % 4 == 0 && year % 100 != 0 )

number = 0

while month > 1 && month -= 1
  number += months[month]
end

number += day

puts "порядковый номер даты, начиная отсчет с начала года: #{number}"
