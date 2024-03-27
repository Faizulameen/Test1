require 'json'

class HashManipulator
  attr_reader :data, :other_args

  def initialize(data, *other_args)
    @data = data
    @other_args = other_args
  end

  def problem_one_solution
    clients = {}
    data.each do |entry|
      client = entry['client']
      location = entry['location']
      amount = entry['amount']

      clients[client] ||= {}
      clients[client][location] ||= { 'amount' => 0 }
      clients[client][location]['amount'] += amount
    end
    clients.map { |client, locations| { 'client' => client, **locations } }
  end

  def problem_two_solution
    clients = {}
    data.each do |entry|
      client = entry['client']
      location = entry['location']
      month = entry['month']
      amount = entry['amount']

      clients[client] ||= {}
      clients[client][location] ||= {}
      clients[client][location][month] = amount
    end
    clients.map { |client, locations| { 'client' => client, **locations } }
  end

  def problem_three_solution
    clients = {}
    data.each do |entry|
      client = entry['client']
      location = entry['location']
      month = entry['month']
      amount = entry['amount']
      amount2 = entry['amount2']

      clients[client] ||= {}
      clients[client][location] ||= {}
      clients[client][location][month] ||= {}
      clients[client][location][month]['amount'] = amount
      clients[client][location][month]['amount2'] = amount2.nil? ? 'null' : amount2
    end
    clients.map { |client, locations| { 'client' => client, **locations } }
  end
end

data = JSON.parse(File.read('./data.json'))
# Running assertions to test the solutions
assert_equal data.dig('problem_one', 'response'), HashManipulator.new(data.dig('problem_one', 'data')).problem_one_solution

assert_equal data.dig('problem_two', 'response'), HashManipulator.new(data.dig('problem_two', 'data')).problem_two_solution

assert_equal data.dig('problem_three', 'response'), HashManipulator.new(data.dig('problem_three', 'data')).problem_three_solution

def assert_equal(expected, actual)
   if expected.to_s == actual.to_s  
     puts "Assertion passed"    
   else    
     puts "Assertion failed"    
   end    
 end 
