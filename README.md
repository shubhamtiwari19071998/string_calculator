# String Calculator TDD Kata

This is a Ruby implementation of the **String Calculator TDD Kata**. The project demonstrates implementing a string calculator using Test-Driven Development principles, supporting custom delimiters, event subscriptions, and various constraints.

## Features

- Add numbers provided in a string.
- Default delimiters: `,` and `\n`.
- Custom delimiters: single or multiple delimiters of any length.
- Ignore numbers greater than 1000.
- Throws exception for negative numbers.
- Keeps track of how many times the `add` method has been called.
- Event subscription system to trigger callbacks after addition.

## Assumptions

- Input strings are well-formed (numbers separated by valid delimiters).
- Custom delimiters, if provided, are defined at the start of the string in the format `//<delimiter>\n` or `//[<delimiter1>][<delimiter2>]...\n`.
- Only integer numbers are considered; decimals are not supported.
- Numbers larger than 1000 are ignored in the sum.
- Negative numbers always raise an exception.
- The `add` method is expected to handle nil or empty strings gracefully by returning 0.

## Installation

Clone the repository and navigate to the project folder:

```bash
git clone <repo-url>
cd string_calculator
```

Install RSpec if you want to run the tests:

```bash
gem install rspec
```

## Usage

```ruby
require_relative 'lib/string_calculator'

calculator = StringCalculator.new

# Add numbers
puts calculator.add('1,2,3')  # => 6

# Custom delimiters
puts calculator.add('//[***]\n1***2***3')  # => 6

# Get called count
puts calculator.get_called_count  # => Number of times add was called

# Event subscription
calculator.on_add do |input, result|
  puts "Add was called with '#{input}', result = #{result}"
end
calculator.add('7,8')  # Triggers event
```

## Running Tests

RSpec tests are included in `spec/string_calculator_spec.rb`:

```bash
rspec spec/string_calculator_spec.rb
```

All tests cover:

- Empty string handling
- Single/multiple numbers
- Newline delimiters
- Custom delimiters (single/multiple, any length)
- Negative number exceptions
- Numbers > 1000 ignored
- Call count
- Event system

## Example Outputs

```ruby
calculator = StringCalculator.new
calculator.add('1,2')         # => 3
calculator.add('1\n2,3')      # => 6
calculator.add('//;\n1;2')    # => 3
calculator.add('2,1001')       # => 2
calculator.add('//[***]\n1***2***3')  # => 6
calculator.get_called_count     # => 5
```
