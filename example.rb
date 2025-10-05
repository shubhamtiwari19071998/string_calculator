require_relative "lib/string_calculator"

calculator = StringCalculator.new

puts "== String Calculator TDD Kata Examples =="

# 1. Empty string
puts "Input: '' => #{calculator.add('')}"

# 2. Single number
puts "Input: '1' => #{calculator.add('1')}"

# 3. Two numbers
puts "Input: '1,2' => #{calculator.add('1,2')}"

# 4. Unknown amount of numbers
puts "Input: '1,2,3,4,5' => #{calculator.add('1,2,3,4,5')}"

# 5. Newline delimiter
puts "Input: '1\\n2,3' => #{calculator.add("1\n2,3")}"

# 6. Custom delimiter
puts "Input: '//;\\n1;2' => #{calculator.add("//;\n1;2")}"

# 7. Exception for negatives
begin
  calculator.add("1,-2,3")
rescue ArgumentError => e
  puts "Input: '1,-2,3' => Exception: #{e.message}"
end

# 8. Ignore numbers > 1000
puts "Input: '2,1001' => #{calculator.add("2,1001")}"

# 9. Delimiter of any length
puts "Input: '//[***]\\n1***2***3' => #{calculator.add("//[***]\n1***2***3")}"

# 10. Multiple delimiters
puts "Input: '//[*][%]\\n1*2%3' => #{calculator.add("//[*][%]\n1*2%3")}"

# 11. Multiple delimiters with length > 1
puts "Input: '//[**][%%]\\n1**2%%3' => #{calculator.add("//[**][%%]\n1**2%%3")}"

# 12. Call count
puts "Add() has been called #{calculator.get_called_count} times so far."

# 13. Event system (subscribe to add)
calculator.on_add do |input, result|
  puts "[Event] Add was called with '#{input}', result = #{result}"
end
calculator.add("7,8") # should trigger event
