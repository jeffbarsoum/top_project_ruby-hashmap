# frozen_string_literal: true

require 'hash'

# Generates unique hashes for keys and stores them in buckets
class HashSet < Hash
  # forcing child method to only accept a key and not a value
  def set(key) # rubocop:disable Lint/UselessMethodDefinition
    super(key)
  end

  # returns an array containing all the keys inside the hash map.
  def keys
    nodes.map { |node| node.value[:key] }.compact
  end
end
