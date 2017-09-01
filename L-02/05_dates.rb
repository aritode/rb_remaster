puts 'Введите число: '
day = gets.chomp.to_i

puts 'Введите месяц: '
month = gets.chomp.to_i

puts 'Введите год: '
year = gets.chomp.to_i

months = {
    january: 31,
    february: 28,
    march: 31,
    april: 30,
    may: 31,
    june: 30,
    july: 31,
    august: 31,
    september: 30,
    october: 31,
    november: 30,
    december: 31
}

months[:february] = 29 if year % 400 == 0 || year % 4 == 0

number = 0

months.each do |key, value|
  number += value if month > 1
  month -= 1
end

number += day

puts "порядковый номер даты, начиная отсчет с начала года: #{number}"
