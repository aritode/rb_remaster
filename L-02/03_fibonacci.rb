fibonacci = 0
fibonacci_arr = [0, 1]
max_value = 100

while fibonacci < max_value
  fibonacci = fibonacci_arr[-1] + fibonacci_arr[-2]
  fibonacci_arr << fibonacci if fibonacci < max_value
end

print fibonacci_arr
