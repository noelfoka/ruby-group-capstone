require_relative '../classes/book'

describe Book do
  describe '#can_be_archived?' do
    it 'returns true if the publish date is more than 10 years ago' do
      book = Book.new('2000-01-01', 'Publisher', 'good')
      expect(book.can_be_archived?).to be true
    end

    it 'returns true if the cover state is bad' do
      book = Book.new('2023-01-01', 'Publisher', 'bad')
      expect(book.can_be_archived?).to be true
    end

    it 'returns false if the publish date is not more than 10 years ago and the cover state is not bad' do
      book = Book.new('2021-01-01', 'Publisher', 'good')
      expect(book.can_be_archived?).to be false
    end
  end

  describe '#to_h' do
    it 'returns a hash with publisher, publish date, and cover state' do
      book = Book.new('2020-01-01', 'Publisher', 'good')
      expected_hash = {
        'publisher' => 'Publisher',
        'publish_date' => '2020-01-01',
        'cover_state' => 'good'
      }
      expect(book.to_h).to eq(expected_hash)
    end
  end

  describe '#bad_cover?' do
    it 'returns true if the cover state is bad' do
      book = Book.new('2023-01-02', 'Publisher', 'bad')
      expect(book.bad_cover?).to be true
    end

    it 'returns false if the cover state is not bad' do
      book = Book.new('2023-01-01', 'Publisher', 'good')
      expect(book.bad_cover?).to be false
    end
  end
end
