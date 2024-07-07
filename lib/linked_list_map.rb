# frozen_string_literal: true

require 'linked_list'

# Linked list built from prior assignment,
# used in our Parent Hash class for both
# HashSet and HashMap
class LinkedListMap < LinkedList
  def initialize(key = nil, value = nil)
    super([key, value]) unless key.nil?
  end

  # returns the index of the node containing value, or nil if not found.
  def find(value, type = :key)
    size.times do |i|
      list_value = at(i).instance_variable_get(type)
      return i if type == :key && list_value[0] == value
      return i if type == :value && list_value[1] == value
      return i if type == :hash && list_value == value
    end
    false
  end

  # represent your LinkedList objects as strings,
  # so you can print them out and preview them in the console.
  #
  # The format should be: ( value ) -> ( value ) -> ( value ) -> nil
  def to_s
    str = ''
    size.times do |i|
      str += "( { #{at(i).value[0]}: #{at(i).value[1]} } )"
      str += ' -> '
    end
    str += 'nil'
    str
  end

  # inserts a new node with the provided value at the given index.
  def insert_at(key, value, index)
    super([key, value], index)
  end
end
