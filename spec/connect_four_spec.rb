# frozen-string-literal: true

require '../lib/connect_four'

describe Game do
  subject(:game) { described_class.new }

  describe '#initialize' do
    # create instance variable of the board, and call new_player no test needed
  end

  describe '#new_player' do
    before do
      allow(Player).to receive(:new)
    end

    it 'sends initialize to Player class' do
      expect(Player).to receive(:new)
      game.new_player
    end
  end
end
