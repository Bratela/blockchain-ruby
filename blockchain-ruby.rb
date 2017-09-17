require 'digest'
require 'pp'

class Block
  attr_reader :hash, :index, :timestamp, :data, :previous_hash

  def initialize(index:, timestamp: Time.now, data:, previous_hash:)
    @index = index
    @timestamp = timestamp
    @data = data
    @previous_hash = previous_hash

    sha = Digest::SHA256.new
    sha.update(index.to_s + timestamp.to_s + data.to_s + previous_hash.to_s)
    @hash = sha.hexdigest
  end
end

b0 = Block.new(index: 0, data: 'It begins', previous_hash: '0')
b1 = Block.new(index: b0.index + 1, data: 'First transaction',  previous_hash: b0.hash)
b2 = Block.new(index: b1.index + 1, data: 'Second transaction', previous_hash: b1.hash)
b3 = Block.new(index: b2.index + 1, data: 'Third transaction',  previous_hash: b2.hash)

pp [b0, b1, b2, b3]
