# frozen_string_literal: true

require 'linked_list'

# This master class will be used for both HashSet and HashMap,
# since they share a lot of the same functionality
#
# Note that both the HashSet and HashMap classes are short,
# because most of the share functionality (and code) lives in the
# parent Hash class
class Hash
  attr_accessor :capacity, :load_factor, :growth_factor, :buckets

  def initialize
    self.capacity = 16
    self.load_factor = 0.75
    self.growth_factor = 2
    self.buckets = []
    capacity.times { |bucket_index| @buckets[bucket_index] = nil }
    puts "buckets after initialization: \n#{buckets}"
  end

  # takes a key and produces a hash code with it.
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value = nil)
    overwritten = overwrite(key, value) if value
    return overwritten if overwritten

    hash = hash(key)
    bucket = bucket(hash)
    bucket ||= LinkedList.new
    val = { key:, value: }
    bucket.append(hash, **val)

    @buckets[check_index(bucket_index(hash))] ||= bucket
    puts "buckets after appending hash: #{hash}, value_hash: #{val}:\n#{buckets}"
    expand if check_capacity
  end

  def overwrite(key, value)
    found = find(key)
    if found
      node = buckets[found[:buckets_index]].at(found[:bucket_index])
      puts "Overwite [ #{node.value[:key]}, #{node.value[:value]} ] with [ #{key}, #{value} ]"
      node.value[:value] = value
      puts "Overwitten value: [ #{node.value[:key]}, #{node.value[:value]} ]"
      return { key: node.value[:key], value: node.value[:value] }
    end
    false
  end

  # Checks if our bucket is at load_factor% capacity,
  # and increases capacity by growth_factor% if it does
  def expand
    is_full = check_capacity
    return false unless is_full

    self.capacity += is_full
    new_buckets = Array.new(capacity, nil)
    nodes.each do |node|
      bucket_index = bucket_index(node.hash)
      new_buckets[bucket_index] = LinkedList.new
      new_buckets[bucket_index].append(node.hash, **node.value)
    end
    puts "buckets expanded: \n#{new_buckets}"
    self.buckets = new_buckets
  end

  def linked_list
    cls_name = self.class.name.gsub('Hash', 'LinkedList')
    Object.const_get(cls_name)
  end

  def check_capacity
    growth_threshold = (capacity * load_factor).ceil
    key_count = keys.length
    additional_buckets = key_count > growth_threshold ? capacity * (growth_factor - 1) : 0

    return false if additional_buckets.zero?

    additional_buckets
  end

  # takes one argument as a key and returns the value that is assigned to this key. If key is not found, return nil.
  def get(value, type = :key)
    found = find(value, type)
    return buckets[found[:buckets_index]].at(found[:bucket_index]) if found

    false
  end

  # checks to make sure the index to reference the bucket is for a bucket that exists
  # per the assignment, an error is raised if it's not
  def bucket_index(hash)
    hash % capacity
  end

  def bucket(hash)
    puts "bucket(#{hash}: bucket_index(#{hash}) = #{bucket_index(hash)}"
    buckets[bucket_index(hash)]
  end

  # takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
  def has?(value, type = :key)
    return true if find(value, type)

    false
  end

  def find(value, type = :key)
    found = nil
    buckets.length.times do |i|
      raise IndexError if i.negative? || i >= @buckets.length

      bucket = buckets[i]
      next unless bucket

      found = bucket.find(value, type)
      return { buckets_index: i, bucket_index: found } if found
    end
    false
  end

  # takes a key as an argument. If the given key is in the hash map,
  # it should remove the entry with that key and return the deleted entry’s value.
  # If the key isn’t in the hash map, it should return nil.
  def remove(value, type = :key)
    found = find(value, type)
    return buckets[found[:buckets_index]].remove_at(found[:bucket_index]) if found

    false
  end

  def check_index(index)
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  # returns the number of stored keys in the hash map.
  def length
    keys.length
  end

  # removes all entries in the hash map.
  def clear
    initialize
  end

  # returns an array containing all the nodes inside the hash map.
  def nodes
    nodes_array = []
    buckets.each do |bucket|
      pointer = bucket.head if bucket
      next if pointer.nil?

      until pointer.nil?
        nodes_array << pointer
        pointer = pointer.next_node
      end
    end
    nodes_array
  end
end
