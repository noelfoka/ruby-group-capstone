require_relative 'spec_helper'

describe Game do
  before :each do
    @game = Game.new('2009-03-02', 'yes', '2020-04-03')
    @game1 = Game.new('2020-03-02', 'no', '2022-06-01')
  end

  describe '#new' do
    it 'returns a new game object' do
      expect(@game).to be_an_instance_of(Game)
      expect(@game1).to be_an_instance_of(Game)
    end
  end

  describe '#multiplayer' do
    it 'returns the correct multiplayer value' do
      expect(@game.multiplayer).to eq('yes')
      expect(@game1.multiplayer).to eq('no')
    end
  end

  describe '#last_played_at' do
    it 'returns the correct last played date' do
      expect(@game.last_played_at.strftime('%Y-%m-%d')).to eq('2020-04-03')
      expect(@game1.last_played_at.strftime('%Y-%m-%d')).to eq('2022-06-01')
    end
  end

  describe '#can_be_archived?' do
    it 'returns the correct archive status' do
      expect(@game.can_be_archived?).to be true
      expect(@game1.can_be_archived?).to be false
    end
  end
end
