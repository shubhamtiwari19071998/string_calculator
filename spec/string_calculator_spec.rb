require_relative "../lib/string_calculator"

RSpec.describe StringCalculator do
  let(:calculator) { described_class.new }

  describe "#add" do
    it "returns 0 for an empty string" do
      expect(calculator.add("")).to eq(0)
    end

    it "returns number for a single input" do
      expect(calculator.add("1")).to eq(1)
    end

    it "returns sum for two numbers" do
      expect(calculator.add("1,2")).to eq(3)
    end

    it "handles an unknown amount of numbers" do
      expect(calculator.add("1,2,3,4,5")).to eq(15)
    end

    it "handles newlines as delimiters" do
      expect(calculator.add("1\n2,3")).to eq(6)
    end

    it "supports custom delimiters" do
      expect(calculator.add("//;\n1;2")).to eq(3)
    end

    it "throws exception for single negative number" do
      expect { calculator.add("1,-2") }.to raise_error(ArgumentError, /-2/)
    end

    it "shows all negative numbers in exception" do
      expect { calculator.add("-1,-2,3") }.to raise_error(ArgumentError, /-1, -2/)
    end

    it "ignores numbers bigger than 1000" do
      expect(calculator.add("2,1001")).to eq(2)
    end

    it "supports delimiters of any length" do
      expect(calculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it "supports multiple delimiters" do
      expect(calculator.add("//[*][%]\n1*2%3")).to eq(6)
    end

    it "supports multiple delimiters with length > 1" do
      expect(calculator.add("//[**][%%]\n1**2%%3")).to eq(6)
    end
  end

  describe "#get_called_count" do
    it "returns the number of times add was called" do
      calculator.add("1")
      calculator.add("2,3")
      expect(calculator.get_called_count).to eq(2)
    end
  end

  describe "event subscription" do
    it "triggers callback after add is called" do
      input, result = nil, nil
      calculator.on_add do |numbers, sum|
        input = numbers
        result = sum
      end
      calculator.add("1,2")

      expect(input).to eq("1,2")
      expect(result).to eq(3)
    end
  end
end
