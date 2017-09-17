# "A cryptographic hash function is a procedure that takes data and
# returns a fixed bit string : the hash value, also known as digest.
# Hash functions are also called one-way functions, it is easy to
# compute a digest from a message, but it is infeasible to generate
# a message from a digest."
# source: http://ruby-doc.org/stdlib-2.4.1/libdoc/digest/rdoc/Digest.html
require 'digest'

# A block is similar to a linked list, with one important caveat. "A linked
# list is only required to have a reference to the previous element, a block
# must have an identifier (aka @hash) depending on the previous block's identifier (aka @hash),
# meaning that you cannot replace a block without recomputing every single block that comes after."
# source: https://www.reddit.com/r/ruby/comments/70c30f/build_your_own_blockchain_in_20_lines_of_ruby/dn2dowu/
#
# Here we're defining a Block class. "Think of classes as molds and objects as the things you produce
# out of those molds. Individual objects will contain different information from other objects, yet
# they are instances of the same class." For example:
#
#   class Dog
#     attr_accessor :name
#
#     def initialize(name: 'Fido')
#       @name = name
#     end
#   end
#
# Usage:
#
#   fido   = Dog.new
#   lassie = Dog.new(name: 'Lassie')
#   buddy  = Dog.new(name: 'Buddy')
#
# source: https://launchschool.com/books/oo_ruby/read/the_object_model#whatareobjects
class Block
  # In Ruby, you can generate getter methods for your instance variables (e.g. @hash, @index)
  # by passing them to attr_reader. This allows us to access the object's
  # instance variables once we initialize the block object.
  # For example, if you wish to access the block's @hash, you can either
  # write the getter method yourself...
  #
  #   def hash
  #     @hash
  #   end
  #
  # or you can use:
  #
  #   attr_reader :hash
  #
  # Usage:
  #
  # block = Block.new(...)
  # block.hash
  #
  attr_reader :index, :timestamp, :data, :previous_hash, :hash

  # The initialize method runs every time we call `new` (Block.new) and is typically used to
  # setup your object with it's own unique data/variables based on the parameters you pass in.
  # In this method, we're using a feature from Ruby 2 called keyword arguments. This allows us
  # to make our parameters more explicit and unaffeted by order. The timestamp: param defaults
  # to Time.now.
  # Usage:
  #
  #  Block.new(index: 2, data: 'Hello world', previous_hash: 'onomatopoeia')
  #
  def initialize(index:, timestamp: Time.now, data:, previous_hash:)
    # We're converting all of our parameters to instance variables. This, in combination with
    # `attr_reader`, allows us to access these variables once we initialize the object.
    @index , @timestamp, @data, @previous_hash = index, timestamp, data, previous_hash

    # Using Digest, from Ruby's stdlib (see source in `require digest`) we can generate the identifier
    # for the block based on the inputs given. The most important of these is `previous_hash.to_s` which
    # tells us that this block's existence (identification/id/hash/mojo) is entirely dependent upon
    # the previous block.
    @hash = Digest::SHA256.hexdigest(index.to_s + timestamp.to_s + data.to_s + previous_hash.to_s)
  end
end
