# frozen_string_literal: true

# Parent Node class, for Hashes and LinkedLists, keys and values are added by children
class Node
  # setters and getters for "value" and "next_node"
  attr_accessor :hash, :value, :next_node

  def initialize(hash, **val)
    self.hash = hash
    self.value = {}
    self.next_node = val[:next_node]
    val.each { |k, v| value[k] = v unless k == :next_node }
  end

  def to_s
    value.to_s
  end
end
