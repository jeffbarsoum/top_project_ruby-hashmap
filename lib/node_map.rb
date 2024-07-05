# frozen_string_literal: true

require 'node_set'

# Nodes for the HashMap class, generates a key and value with each node
# Inherits from the NodeSet class, which in turn inherits from Node
class NodeMap < NodeSet
  # setters and getters for "value" and "next_node"
  attr_accessor :value

  def initialize(key = nil, val = nil, nxt_nd = nil)
    super(key, nxt_nd)
    self.value = val
  end

  def to_s
    "{ #{key}: #{value} }"
  end
end
