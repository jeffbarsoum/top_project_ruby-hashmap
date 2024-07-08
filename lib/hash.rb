# frozen_string_literal: true

require 'linked_list'

# Parent Hash class
#
# Note that both the HashSet and HashMap classes are short,
# because most of the share functionality (and code) lives in the
# parent Hash class
class Hash # rubocop:disable Metrics/ClassLength
  def initialize
    @capacity = 16
    @load_factor = 0.75
    @growth_factor = 2
    @buckets = []
    capacity.times { |bucket_index| @buckets[bucket_index] = nil }
    puts "buckets after initialization: \n#{buckets}"
  end

  def set(key, value = nil)
    overwritten = overwrite(key, value)
    return overwritten if overwritten

    hash = hash(key)
    bucket = buckets[bucket_index(hash)]
    bucket ||= LinkedList.new
    val = { key:, value: }
    bucket.append(hash, **val)

    @buckets[check_index(bucket_index(hash))] ||= bucket
    puts "buckets after appending hash: #{hash}, value_hash: #{val}:\n#{buckets}"
    expand if check_capacity
  end

  # takes one argument as a key and returns the value that is assigned to this key.
  # If key is not found, return nil.
  def get(value, type = :key)
    node = get_node(value, type)
    node&.value
  end

  # takes a key as an argument and returns true or false
  # based on whether or not the key is in the hash map.
  def has?(value, type = :key)
    return true if find(value, type)

    false
  end

  # find node based on key or value, default is key
  def find(value, type = :key)
    found = nil
    buckets.length.times do |i|
      bucket = buckets[check_index(i)]
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

    nil
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

  #########################################
  # Private Methods
  #########################################
  private

  attr_reader :capacity, :load_factor, :growth_factor, :buckets

  def check_index(index)
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  # checks to make sure the index to reference the bucket is for a bucket that exists
  # per the assignment, an error is raised if it's not
  def bucket_index(hash)
    hash % capacity
  end

  # takes a key and produces a hash code with it.
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # check if key exists and overwrite value if it does
  def overwrite(key, value) # rubocop:disable Metrics/AbcSize
    node = get_node(key)
    return false unless node

    puts "Overwite [ #{node.value[:key]}, #{node.value[:value]} ] with [ #{key}, #{value} ]"
    node.value[:value] = value
    puts "Overwitten value: [ #{node.value[:key]}, #{node.value[:value]} ]"
    { key: node.value[:key], value: node.value[:value] }
  end

  # Checks if our bucket is at load_factor% capacity,
  # and increases capacity by growth_factor% if it does
  def expand
    is_full = check_capacity
    return false unless is_full

    @capacity += is_full
    @buckets = regen_buckets
    puts "buckets expanded: \n#{buckets}"
  end

  def check_capacity
    growth_threshold = (capacity * load_factor).ceil
    key_count = keys.length
    additional_buckets = key_count > growth_threshold ? capacity * (growth_factor - 1) : 0

    return false if additional_buckets.zero?

    additional_buckets
  end

  def regen_buckets
    new_buckets = Array.new(capacity, nil)
    nodes.each do |node|
      new_buckets[bucket_index(node.hash)] ||= LinkedList.new
      new_buckets[bucket_index(node.hash)].append(node.hash, **node.value)
    end
    new_buckets
  end

  # get node by either key or value
  def get_node(value, type = :key)
    found = find(value, type)
    return buckets[found[:buckets_index]].at(found[:bucket_index]) if found

    nil
  end
end
