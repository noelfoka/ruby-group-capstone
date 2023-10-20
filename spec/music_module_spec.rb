require 'rspec'
require_relative '../modules/music_logic'

describe MusicLibrary do
  include MusicLibrary

  before(:each) do
    @albums = []
    @genres = []
  end

  describe '#add_music_album' do
    it 'creates a music album and assigns genre' do
      allow(self).to receive(:puts)
      allow(self).to receive(:print)

      allow(self).to receive(:gets).and_return(
        'Album 3', '2022-03-01', 'good', 'true', 'false', 'Genre 1'
      )

      add_music_album
      expect(@genres.length).to eq(1)
    end
  end
end
