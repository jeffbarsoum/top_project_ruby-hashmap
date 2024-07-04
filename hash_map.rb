# frozen_string_literal: true

# Use the following snippet whenever you access a bucket through an index.
# We want to raise an error if we try to access an out of bound index:
#
# raise IndexError if index.negative? || index >= @buckets.length
class HashMap
  # takes a key and produces a hash code with it.
  def hash(key); end

  # takes two arguments, the first is a key and the second is a value that is assigned to this key.
  # if a key already exists, then the old value is overwritten or we can say that we update the key’s value.
  def set(key, value); end

  # takes one argument as a key and returns the value that is assigned to this key. If key is not found, return nil.
  def get(key); end

  # takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
  def has?(key); end

  # takes a key as an argument. If the given key is in the hash map,
  # it should remove the entry with that key and return the deleted entry’s value.
  # If the key isn’t in the hash map, it should return nil.
  def remove(key); end

  # returns the number of stored keys in the hash map.
  def length; end

  # removes all entries in the hash map.
  def clear; end

  # returns an array containing all the keys inside the hash map.
  def keys; end

  # returns an array containing all the values.
  def values; end

  # returns an array that contains each key, value pair.
  # Example: [[first_key, first_value], [second_key, second_value]]
  def entries; end
end
