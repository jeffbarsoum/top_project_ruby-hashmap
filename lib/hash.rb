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
    self.load_factor = 0.8
    self.growth_factor = 2
    self.buckets = []
  end

  # takes a key and produces a hash code with it.
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # Checks if our bucket is at load_factor% capacity,
  # and increases capacity by growth_factor% if it does
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
  def get(key)
    bucket(key).at(bucket(key).find(key))
  end

  # checks to make sure the index to reference the bucket is for a bucket that exists
  # per the assignment, an error is raised if it's not
  def bucket_index(key)
    hashed_key = hash(key)
    bucket_index = hashed_key % capacity
    raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

    bucket_index
  end

  def bucket(key)
    buckets[bucket_index(key)]
  end

  # takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
  def has?(key)
    bucket(key).find(key)
  end

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
    self.buckets = []
  end

  # returns an array containing all the nodes inside the hash map.
  def nodes
    nodes_array = []
    buckets.each do |bucket|
      bucket.array.each { |node| keys_array << node }
    end
    nodes_array
  end

  # returns an array containing all the keys inside the hash map.
  def keys
    nodes.map(&:key)
  end
end
