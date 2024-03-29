require 'json'

class HashManipulator
  def initialize(data, keys, other_args = [])
    @data = data
    @keys = keys
    @other_args = other_args
  end

 def problem_one
    grouped_data = @data.group_by { |d| d[@keys[0]] }
    grouped_data.transform_values do |client_data|
      client_data.group_by { |d| d[@keys[1]] }.transform_values do |location_data|
        location_data.group_by { |d| d[@keys[2]] }.transform_values do |month_data|
          { 'amount' => month_data.map { |d| d[@keys[3]] }.compact.sum, 'amount2' => month_data.map { |d| d[@keys[4]] }.compact.sum }
        end.reject { |k, v| v.nil? || v.empty? } # Remove nil or empty values
      end.reject { |k, v| v.nil? || v.empty? } # Remove nil or empty values
    end.reject { |k, v| v.nil? || v.empty? } # Remove nil or empty values
  end

  def problem_two
    grouped_data = @data.group_by { |d| d[@keys[0]] }
    grouped_data.transform_values do |client_data|
      client_data.group_by { |d| d[@keys[1]] }.transform_values do |location_data|
        location_data.group_by { |d| d[@keys[2]] }.transform_values do |month_data|
          { 'amount' => month_data.map { |d| d[@keys[3]] }.compact.sum, 'amount2' => month_data.map { |d| d[@keys[4]] }.compact.sum }
        end
      end
    end
  end

  def problem_three
    grouped_data = @data.group_by { |d| d[@keys[0]] }
    grouped_data.transform_values do |client_data|
      client_data.group_by { |d| d[@keys[1]] }.transform_values do |location_data|
        location_data.group_by { |d| d[@keys[2]] }.transform_values do |month_data|
          { 'amount' => month_data.map { |d| d[@keys[3]] }.compact.sum, 'amount2' => month_data.map { |d| d[@keys[4]] }.compact.sum }
        end
      end
    end
  end
end

data = JSON.parse(File.read('./data.json'))

assert_equal data.dig('problem_one', 'response'), HashManipulator.new(data.dig('problem_one', 'data'), %w[client location amount]).problem_one
assert_equal data.dig('problem_two', 'response'), HashManipulator.new(data.dig('problem_two', 'data'), %w[client location month amount amount2]).problem_two
assert_equal data.dig('problem_three', 'response'), HashManipulator.new(data.dig('problem_three', 'data'), %w[client location month amount amount2]).problem_three

def assert_equal(expected, actual)
   if expected.to_s == actual.to_s  
     puts "Assertion passed #{expected} equal to #{actual}"    
   else    
     puts "Assertion failed #{expected} not equal to #{actual}"    
   end    
 end
