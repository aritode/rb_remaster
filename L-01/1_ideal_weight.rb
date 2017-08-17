print 'Введите ваше имя: '
user_name = gets.chomp

print 'Введите ваш рост: '
user_height  = gets.to_i

ideal_weight = user_height - 110

if ideal_weight < 0
  puts 'Ваш вес уже оптимальный'
else
  puts "#{user_name.capitalize}, ваш идеальный вес: #{ideal_weight}"
end
