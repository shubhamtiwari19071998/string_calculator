class StringCalculator
  attr_reader :call_count

  DEFAULT_DELIMITERS = [",", "\n"].freeze
  MAX_NUMBER = 1000

  def initialize
    @call_count = 0
    @subscribers = []
  end

  # Main method to add numbers from a string
  def add(numbers)
    @call_count += 1
    return 0 if numbers.nil? || numbers.empty?

    delimiters, expression = extract_delimiters(numbers)
    values = tokenize(expression, delimiters)
    validate_negatives!(values)

    result = values.reject { |n| n > MAX_NUMBER }.sum

    notify_subscribers(numbers, result)
    result
  end

  def get_called_count
    @call_count
  end

  def on_add(&block)
    @subscribers << block if block_given?
  end

  private

  def extract_delimiters(numbers)
    if numbers.start_with?("//")
      header, expression = numbers.split("\n", 2)
      expression ||= ""
      delimiters = parse_delimiters(header)
      [delimiters, expression]
    else
      [DEFAULT_DELIMITERS, numbers]
    end
  end

  def parse_delimiters(header)
    if header.start_with?("//[")
      header.scan(/\[(.*?)\]/).flatten
    else
      [header[2]]
    end
  end

  def tokenize(expression, delimiters)
    if delimiters == DEFAULT_DELIMITERS
      # Just scan all numbers
      expression.scan(/-?\d+/).map(&:to_i)
    else
      # Replace custom delimiters with a comma, then scan numbers
      escaped = delimiters.map { |d| Regexp.escape(d) }
      regex = Regexp.union(escaped)
      normalized = expression.gsub(regex, ",")
      normalized.scan(/-?\d+/).map(&:to_i)
    end
  end


  def validate_negatives!(values)
    negatives = values.select(&:negative?)
    return if negatives.empty?

    raise ArgumentError, "negative numbers not allowed: #{negatives.join(', ')}"
  end

  def notify_subscribers(input, result)
    @subscribers.each { |subscriber| subscriber.call(input, result) }
  end
end
