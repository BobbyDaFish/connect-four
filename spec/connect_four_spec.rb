# frozen-string-literal: true

require '../lib/connect_four'

describe Game do
  subject(:game) { described_class.new }

  describe '#initialize' do
    # create instance variable of the board, and call new_player no test needed
  end

  describe '#new_player' do
    before do
      allow(game).to receive(:new_player).with(1).and_return("\u25c6")
    end

    it 'creates new player object' do
      expect(game).to receive(:new_player).with(1)
      game.new_player(1)
    end
  end

  describe '#display_board' do
    it 'prints all 7 rows and header' do
      expect(game).to receive(:puts).exactly(8).times
      game.display_board
    end
  end

  describe '#valid_play?' do # rubocop:disable Metrics/BlockLength
    context 'player submits valid choice' do
      before do
        valid_input = '3'
        allow(game).to receive(:valid_play?).with(valid_input)
      end

      it 'receives valid input and returns that input' do
        expect(game).to receive(:valid_play?).and_return(3)
        game.valid_play?
      end
    end

    context 'player submits number to full column' do
      before do
        full_column = '3'
        board_full = [['_', '_', "\u25c6", '_', '_', '_', '_']]
        allow(game).to receive(:valid_play?).with(full_column, board_full)
      end

      it 'returns false' do
        expect(game).to receive(:valid_play?).and_return(false)
        game.valid_play?
      end
    end

    context 'player submits invalid input' do
      before do
        invalid_input = 'b'
        allow(game).to receive(:valid_play?).with(invalid_input)
      end

      it 'returns false' do
        expect(game).to receive(:valid_play?).and_return(false)
        game.valid_play?
      end
    end
  end

  describe '#place_piece' do
    context 'empty board, first play' do
      before do
        valid_play = 3
        player = game.instance_variable_get(:@player1)
        allow(game).to receive(:place_piece).with(valid_play, player)
      end

      it 'places piece in row 7' do
        expect(game).to receive(:place_piece).and_return("\u25c6")
        game.place_piece
      end
    end

    context 'bottom row already has a piece' do
      before do
        play = 3
        player = game.instance_variable_get(:@player2)
        board = [%w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 ['_', '_', "\u25c6", '_', '_', '_', '_']]
        allow(game).to receive(:place_piece).with(play, player, board)
      end

      it 'places the piece in row 6' do
        expect(game).to receive(:place_piece).and_return("\u25c9")
        game.place_piece
      end
    end
  end

  describe '#create_piece' do
    context 'Create a new piece object' do
      before do
        coords = [6][3]
        player = game.instance_variable_get(:@player2)
        allow(game).to receive(:create_piece).with(player, coords)
      end

      it 'creates piece' do
        expect(game).to receive(:create_piece).and_return(Hash)
        game.create_piece
      end
    end
  end
end
