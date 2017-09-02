# 'Install terminal-table gem:'
# '$ gem install terminal-table'

require 'terminal-table'

puts 'Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара
 (может быть нецелым числом). '
puts 'Введите "стоп" в качестве названия товара для остановки'
puts

products = {}

loop do
  print 'Введите название товара: '
  title = gets.chomp

  break if title == "стоп"

  print 'Введите цену: '
  price = gets.to_f

  print 'Введите кол-во: '
  quantity = gets.to_f

  puts
  products[title] = { price: price, quantity: quantity }
end

puts

rows = products.map do |title, params|
  [title, params[:price], params[:quantity], params[:price] * params[:quantity]]
end

table = Terminal::Table.new :title => 'Ваша корзина',
                            :headings => ['Название товара', 'Стоимость', 'Кол-во', 'Полная цена'],
                            :rows => rows,
                            :style => {:width => 80}
puts table

final_price = products.reduce(0) { |sum, (_title, params)| sum += params[:price] * params[:quantity] }
puts
puts "Итого: #{final_price}"
