# frozen_string_literal: true

require 'node'

# Nodes for the HashSet class, generates a key for each node
class NodeSet < Node
  # setters and getters for "value" and "next_node"
  attr_accessor :key

  def initialize(key = nil, nxt_nd = nil)
    super(nxt_nd)
    self.key = key
  end

  def to_s
    key.to_s
  end
end
