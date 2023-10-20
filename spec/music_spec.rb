require_relative '../classes/music'

RSpec.describe MusicAlbum do
  describe '#initialize' do
    it 'creates a music album with given attributes' do
      album = MusicAlbum.new('Album Name', '2023-08-09', 'good', true)
      expect(album.name).to eq('Album Name')
      expect(album.cover_state).to eq('good')
      expect(album.on_spotify).to eq(true)
    end
  end
end
