# frozen_string_literal: true

require 'node'

# Linked list built from prior assignment,
# used in our Parent Hash class for both
# HashSet and HashMap
class LinkedList
  # setters and getters for first and last node in the list
  attr_accessor :head

  def initialize(value = nil)
    prepend(value) unless value.nil?
  end

  def tail
    next_pointer = head
    while next_pointer
      return next_pointer unless next_pointer.next_node

      next_pointer = next_pointer.next_node
    end
    next_pointer
  end

  # adds a new node containing value to the end of the list
  def append(hash, **val)
    return self.head = Node.new(hash, **val) unless head

    new_tail = Node.new(hash, **val)
    old_tail = tail
    old_tail.next_node = new_tail
  end

  # adds a new node containing value to the start of the list
  def prepend(hash, **val)
    return self.head = Node.new(hash, **val) unless head

    val[:next_node] = head
    new_head = Node.new(hash, **val)
    self.head = new_head
  end

  # returns the total number of nodes in the list
  def size
    cnt = 0
    next_pointer = head
    while next_pointer
      cnt += 1
      next_pointer = next_pointer.next_node
    end
    cnt
  end

  # returns the node at the given index
  def at(index)
    pointer = head
    index.times do |_i|
      pointer = pointer.next_node
    end
    pointer
  end

  # removes the last element from the list
  def pop
    old_tail = tail
    at(size - 2).next_node = nil
    old_tail
  end

  # removes the first element from the list
  def shift
    old_head = head
    self.head = at(1)
    old_head.next_node = nil
    old_head
  end

  # returns true if the passed in value is in the list and otherwise returns false.
  def contains?(value, type = :value)
    return true if find(value, type)

    false
  end

  # returns the index of the node containing value, or nil if not found.
  def find(value, type = :value)
    size.times do |i|
      list_value = type == :hash? ? at(i).hash : at(i).value[type]
      return i if list_value == value
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
      str += "( #{at(i)} )"
      str += ' -> '
    end
    str += 'nil'
    str
  end

  ####################
  # Extra Credit
  ####################

  # inserts a new node with the provided value at the given index.
  def insert_at(hash, index, **val)
    return prepend(hash, val) if index.zero?

    val[:next_node] = at(index)
    at(index - 1).next_node = Node.new(hash, val)
  end

  # removes the node at the given index
  def remove_at(index)
    return false unless at(index)

    prior_obj = at(index - 1)
    next_obj = at(index + 1)
    prior_obj.next_node = next_obj if prior_obj && next_obj
    return shift unless prior_obj
    return pop unless next_obj

    at(index)
  end
  ####################
  # Added for HashMap
  ####################

  def array
    result = []
    next_pointer = head
    while next_pointer
      result << next_pointer
      next_pointer = next_pointer.next_node
    end
    result
  end
end
