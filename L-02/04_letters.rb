letters = ["a", "e", "i", "o", "u", "y"]

dictionary = Hash.new
i = 1

('a'..'z').each do |letter|
  dictionary[letter] = i if letters.include? letter
  i += 1
end

print dictionary
