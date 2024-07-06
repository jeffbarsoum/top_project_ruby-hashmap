# frozen_string_literal: true

require 'hash'
require 'linked_list'

# Generates unique hashes for keys and stores them in buckets
class HashSet < Hash
  def initialize
    super
    self.buckets = []
    capacity.times { |bucket_index| @buckets[bucket_index] = LinkedList.new }
    puts "buckets after initialization: \n#{buckets}"
  end

  # takes two arguments, the first is a key and the second is a value that is assigned to this key.
  # if a key already exists, then the old value is overwritten or we can say that we update the key’s value.
  def set(key)
    bucket(key).append(key)
    expand
  end
end
