# frozen_string_literal: true

require_relative 'linked_lists'

# Use the following snippet whenever you access a bucket through an index.
# We want to raise an error if we try to access an out of bound index:
#
# raise IndexError if index.negative? || index >= @buckets.length
class HashMap
  attr_accessor :capacity, :load_factor, :growth_factor, :buckets

  def initialize
    self.capacity = 16
    self.load_factor = 0.8
    self.growth_factor = 2
    self.buckets = Array.new(capacity, Node.new)
  end

  # takes a key and produces a hash code with it.
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # takes two arguments, the first is a key and the second is a value that is assigned to this key.
  # if a key already exists, then the old value is overwritten or we can say that we update the key’s value.
  def set(key, value)
    hashed_key = hash(key)
    bucket_index = hashed_key % capacity
    raise IndexError if bucket_index.negative? || index >= @buckets.length

    @buckets[bucket_index].append(key, value)
    expand
  end

  def expand
    growth_threshold = (capacity * load_factor).ceil
    additional_buckets = keys.length >= growth_threshold ? capacity * (growth_factor - 1) : 0

    return false if additional_buckets.zero?

    additional_buckets.times do |_bucket|
      @buckets << Node.new
    end
    self.capacity = @buckets.length
  end

  # takes one argument as a key and returns the value that is assigned to this key. If key is not found, return nil.
  def get(key); end

  # takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
  def has?(key); end

  # takes a key as an argument. If the given key is in the hash map,
  # it should remove the entry with that key and return the deleted entry’s value.
  # If the key isn’t in the hash map, it should return nil.
  def remove(key)
    bucket(key).remove_at(bucket(key).find(key))
  end

  # returns the number of stored keys in the hash map.
  def length
    keys.length
  end

  # removes all entries in the hash map.
  def clear
    initialize
  end

  # returns an array containing all the keys inside the hash map.
  def keys
    keys_array = []
    buckets.each do |bucket|
      bucket.array.each { |node| keys_array << node.key }
    end
    keys_array
  end

  # returns an array containing all the values.
  def values
    values_array = []
    buckets.each do |bucket|
      bucket.array.each { |node| values_array << node.value }
    end
    values_array
  end

  # returns an array that contains each key, value pair.
  # Example: [[first_key, first_value], [second_key, second_value]]
  def entries
    entries_array = []
    buckets.each do |bucket|
      bucket.array.each { |node| entries_array << [node.key, node.value] }
    end
    entries_array
  end
end
