letters = ["a", "e", "i", "o", "u", "y"]

dictionary = {}

('a'..'z').each.with_index(1) do |letter, index|
  dictionary[letter] = index if letters.include? letter
end

print dictionary
