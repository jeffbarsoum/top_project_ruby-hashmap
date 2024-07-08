# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'hash_map'
require 'hash_set'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts 'should be at full capacity with load factor = 0,75'

# overwriting a few nodes..
puts '# overwriting a few nodes..'
puts 'this should only over-write the existing values of your nodes and not add new ones.'
test.set('hat', 'yellow')
test.set('ice cream', 'purple')
test.set('jacket', 'red')
test.set('kite', 'blue')
test.set('lion', 'black')

# populate hash map with the last node below
# (doing this will make hash map exceed current load factor,
# hence expanding buckets and growing hash map)
#
# capacity of hash map should drop well below your load factor
# should notice that nodes in  hash map are spread much evenly among buckets

puts 'populate hash map with the last node below'
puts 'capacity of hash map should drop well below your load factor'
test.set('moon', 'silver')

puts '# overwriting a few nodes..'
puts 'this should only over-write the existing values of your nodes and not add new ones.'
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts 'Test the other methods of your hash maps'
puts "get(ice cream): #{test.get('ice cream')}"
puts "has?(hat): #{test.has?('hat')}"
puts "remove(jacket): #{test.remove('jacket')}"
puts "length: #{test.length}"
puts "clear: #{test.clear}"
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
puts "keys: #{test.keys}"
puts "values: #{test.values}"
puts "entries: #{test.entries}"

puts "#################################################\n\n\nTEST HashSet"
test2 = HashSet.new
test2.set('apple')
test2.set('banana')
test2.set('carrot')
test2.set('dog')
test2.set('elephant')
test2.set('frog')
test2.set('grape')
test2.set('hat')
test2.set('ice cream')
test2.set('jacket')
test2.set('kite')
test2.set('lion')

puts 'this should only over-write the existing values of your nodes and not add new ones.'
test2.set('hat')
test2.set('ice cream')
test2.set('jacket')
test2.set('kite')

puts 'populate hash map with the last node below'
puts 'capacity of hash map should drop well below your load factor'
test2.set('moon')

puts 'Test the other methods of your hash sets'
puts "get(ice cream): #{test2.get('ice cream')}"
puts "has?(hat): #{test2.has?('hat')}"
puts "remove(jacket): #{test2.remove('jacket')}"
puts "length: #{test2.length}"
puts "clear: #{test2.clear}"
test2.set('hat')
test2.set('ice cream')
test2.set('jacket')
test2.set('kite')
puts "keys: #{test2.keys}"

puts 'The below entry should throw an error:'
test2.set('lion', 'golden')
