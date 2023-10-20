require_relative 'item'

class MusicAlbum < Item
  attr_accessor :name, :publish_date, :cover_state, :on_spotify

  def initialize(name, publish_date, cover_state, on_spotify, archived: false)
    super(publish_date, archived: archived)
    @id = Random.rand(1..1000)
    @name = name
    @cover_state = cover_state
    @on_spotify = on_spotify
  end

  def to_hash
    {
      'id' => @id,
      'name' => @name,
      'publish_date' => @publish_date.strftime('%Y-%m-%d'),
      'cover_state' => @cover_state,
      'on_spotify' => @on_spotify,
      'archived' => @archived
    }
  end

  def can_be_archived?
    super && @on_spotify
  end
end
