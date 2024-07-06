# frozen_string_literal: true

require 'hash'
require 'linked_list_map'

# Generates a key: value pair for each key, via NodeMap class
class HashMap < Hash
  def initialize
    super
    self.buckets = []
    capacity.times { |bucket_index| @buckets[bucket_index] = LinkedListMap.new }
    puts "buckets after initialization: \n#{buckets}"
  end

  # Checks if our bucket is at load_factor% capacity,
  # and increases capacity by growth_factor% if it does
  def expand
    is_full = check_capacity
    return false unless is_full

    is_full.times do |_bucket|
      @buckets << LinkedListMap.new
    end
    self.capacity = buckets.length
    puts "bucket expanded to #{capacity}..."
  end

  def check_capacity
    growth_threshold = (capacity * load_factor).ceil
    key_count = keys.length
    additional_buckets = key_count >= growth_threshold ? capacity * (growth_factor - 1) : 0

    return false if additional_buckets.zero?

    additional_buckets
  end

  # takes two arguments, the first is a key and the second is a value that is assigned to this key.
  # if a key already exists, then the old value is overwritten or we can say that we update the key’s value.
  def set(key, value)
    bucket(key).append([key, value])
    puts "buckets after appending [#{key},#{value}]:\n#{buckets}"
    expand if check_capacity
  end

  # returns an array containing all the keys inside the hash map.
  def keys
    keys = nodes.map { |node| node.value[0] }
  end

  # returns an array containing all the keys inside the hash map.
  def values
    nodes.map(&:value[1])
  end

  # returns an array that contains each key, value pair.
  # Example: [[first_key, first_value], [second_key, second_value]]
  def entries
    nodes.map { |node| [node.value[0], node.value[1]] }
  end
end
