require_relative '../classes/genre'

RSpec.describe Genre do
  describe '#initialize' do
    it 'creates a genre with a name' do
      genre = Genre.new('Rock')
      expect(genre.name).to eq('Rock')
    end
  end
end
