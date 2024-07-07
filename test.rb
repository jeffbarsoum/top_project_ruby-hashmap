# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'hash_map'

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
# this should only over-write the existing values of your nodes and not add new ones.
test.set('hat', 'yellow')
test.set('ice cream', 'purple')
test.set('jacket', 'red')
test.set('kite', 'blue')
test.set('lion', 'black')

# populate hash map with the last node below
# (doing this will make hash map exceed current load factor,
# hence expanding buckets and growing hash map)
#
# capacity of yash map should drop well below your load factor
# should notice that nodes in  hash map are spread much evenly among buckets
test.set('moon', 'silver')

# overwriting a few nodes..
# this should only over-write the existing values of your nodes and not add new ones.
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

# Test the other methods of your hash maps
# to check if they are still working as expected after expanding hash map.
# get(key)
# has?(key)
# remove(key)
# length
# clear
# keys
# values
# entries
