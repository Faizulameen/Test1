require 'json'

class HashManipulator

# Constructor the intialize
  def initialize(data, *keys)
    @data = data
    @keys = keys
  end

def problem_solved
  response = [] #creating one empty array
  @data.group_by { |d| d[@keys[0]] }.each do |client, client_data| #grouping client 
    client_hash = { @keys[0] => client } 
    location_hash = {}
    client_data.group_by { |d| d[@keys[1]] }.each do |location, location_data| #grouping location based on location amount calculating
      location_hash[location] = {
        'amount' => location_data.sum { |d| d[@keys[2]].to_i }
      }
    end
    client_hash.merge!(location_hash) #finally merge the values and pushed to array
    response << client_hash
  end
  response
end

end

data = JSON.parse(File.read('./data.json'))

keys = %w[client location amount] # Example keys, you can change these as needed
assert_equal data.dig('problem_one', 'response'), HashManipulator.new(data.dig('problem_one', 'data'), *keys).problem_solved

def assert_equal(expected, actual)
   if expected.to_s == actual.to_s  
     puts "Assertion passed #{expected} equal to #{actual}"    
   else    
     puts "Assertion failed #{expected} not equal to #{actual}"    
   end    
 end
