fibonacci_arr = [0, 1]
max_value = 100

while (fibonacci = fibonacci_arr[-1] + fibonacci_arr[-2]) < max_value
  fibonacci_arr << fibonacci
end

print fibonacci_arr
