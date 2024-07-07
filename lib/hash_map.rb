# frozen_string_literal: true

require 'hash'
require 'linked_list_map'

# Generates a key: value pair for each key, via NodeMap class
class HashMap < Hash
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
