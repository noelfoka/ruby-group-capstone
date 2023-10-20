require_relative 'spec_helper'

describe Author do
  before :each do
    @author = Author.new('Stephen', 'King')
  end

  describe '#new' do
    it 'returns a new author object' do
      expect(@author).to be_an_instance_of(Author)
    end
  end

  describe '#first_name' do
    it 'returns the first name of the author' do
      expect(@author.first_name).to eq('Stephen')
    end
  end

  describe '#last_name' do
    it 'returns the last name of the author ' do
      expect(@author.last_name).to eq('King')
    end
  end

  describe '#add_item' do
    it 'adds an item to the author\'s items' do
      item = Item.new('01-01-2000')
      @author.add_item(item)
      expect(@author.items).to include(item)
    end
  end
end
