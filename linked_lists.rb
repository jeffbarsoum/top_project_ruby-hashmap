# frozen_string_literal: true

class LinkedList
  # setters and getters for first and last node in the list
  attr_accessor :head

  def initialize(value)
    prepend(value)
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
  def append(key, value)
    if head.key && head.value
      new_tail = Node.new(key, value)
      old_tail = tail
      old_tail.next_node = new_tail
    else
      head.key = key
      head.value = value
    end
  end

  # adds a new node containing value to the start of the list
  def prepend(key, value)
    if head.key && head.value
      new_node = Node.new(key, value, head)
      self.head = new_node
    else
      head.key = key
      head.value = value
    end
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
  def contains?(key)
    return true if find(key)

    false
  end

  # returns the index of the node containing value, or nil if not found.
  def find(key)
    size.times do |i|
      return i if at(i).key == key
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
  def insert_at(value, index)
    return prepend(value) if index.zero?

    at(index - 1).next_node = Node.new(value, at(index))
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
end

class Node
  # setters and getters for "value" and "next_node"
  attr_accessor :key, :value, :next_node

  def initialize(key = nil, val = nil, nxt_nd = nil)
    self.key = key
    self.value = val
    self.next_node = nxt_nd
  end

  def to_s
    value.to_s
  end
end
