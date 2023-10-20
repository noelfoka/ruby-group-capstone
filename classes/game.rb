require_relative 'item'
require 'date'

# class Game
class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = DateTime.strptime(last_played_at, '%Y-%m-%d')
  end

  def can_be_archived?
    super && (Time.now.year - @last_played_at.year) > 2
  end

  def to_hash
    {
      publish_date: @publish_date.strftime('%Y-%m-%d'),
      multiplayer: @multiplayer,
      last_played_at: @last_played_at.strftime('%Y-%m-%d')
    }
  end

  def self.from_hash(hash)
    new(
      hash['publish_date'],
      hash['multiplayer'],
      hash['last_played_at']
    )
  end
end
