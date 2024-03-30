require 'json'

class HashManipulator
  def initialize(data, keys)
    @data = data
    @keys = keys
  end

def problem_solved
  response = []
  @data.group_by { |d| d[@keys[0]] }.each do |client, client_data|
    client_hash = { @keys[0] => client }
    location_hash = {}
    client_data.group_by { |d| d[@keys[1]] }.each do |location, location_data|
      location_hash[location] = {
        'amount' => location_data.sum { |d| d[@keys[2]].to_i }
      }
    end
    client_hash.merge!(location_hash)
    response << client_hash
  end
  response
end

end

data = JSON.parse(File.read('./data.json'))

# assert_equal data.dig('problem_one', 'response'), HashManipulator.new(data.dig('problem_one', 'data'), %w[client location amount]).problem_one
# assert_equal data.dig('problem_two', 'response'), HashManipulator.new(data.dig('problem_two', 'data'), %w[client location month amount amount2]).problem_two
# assert_equal data.dig('problem_three', 'response'), HashManipulator.new(data.dig('problem_three', 'data'), %w[client location month amount amount2]).problem_three

assert_equal data.dig('problem_one', 'response'), HashManipulator.new(data.dig('problem_one', 'data'), %w[client location amount]).problem_solved


def assert_equal(expected, actual)
   if expected.to_s == actual.to_s  
     puts "Assertion passed #{expected} equal to #{actual}"    
   else    
     puts "Assertion failed #{expected} not equal to #{actual}"    
   end    
 end
