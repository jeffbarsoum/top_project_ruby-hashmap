# frozen_string_literal: true

require 'hash'

# Generates a key: value pair for each key, via NodeMap class
class HashMap < Hash
  def initialize
    super
    self.buckets = Array.new(capacity, NodeMap.new)
  end

  # takes two arguments, the first is a key and the second is a value that is assigned to this key.
  # if a key already exists, then the old value is overwritten or we can say that we update the key’s value.
  def set(key, value)
    bucket(key).append(key, value)
    expand
  end

  # returns an array containing all the keys inside the hash map.
  def values
    nodes.map(&:value)
  end

  # returns an array that contains each key, value pair.
  # Example: [[first_key, first_value], [second_key, second_value]]
  def entries
    nodes.map { |node| [node.key, node.value] }
  end
end
