# frozen_string_literal: true

# Parent Node class, for Hashes and LinkedLists, keys and values are added by children
class Node
  # setters and getters for "value" and "next_node"
  attr_accessor :next_node

  def initialize(nxt_nd = nil)
    self.next_node = nxt_nd
  end

  def to_s
    value.to_s
  end
end
