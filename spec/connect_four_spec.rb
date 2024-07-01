# frozen-string-literal: true

require '../lib/connect_four'
require 'pry-byebug'

describe Game do # rubocop:disable Metrics/BlockLength
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

  describe '#valid_play?' do
    context 'player submits valid choice' do
      it 'receives valid input and returns that input' do
        valid_input = 3
        play = game.valid_play?(valid_input)

        expect(play).to be(3)
      end
    end

    context 'player submits number to full column' do
      it 'returns false' do
        full_column = 3
        board_full = [['_', '_', "\u25c6", '_', '_', '_', '_']]
        invalid = game.valid_play?(full_column, board_full)

        expect(invalid).to be(false)
      end
    end

    context 'player submits invalid input' do
      # before do
      #   allow(game).to receive(:valid_play?).with(invalid_input)
      # end

      it 'returns false' do
        bad_input = 'b'
        invalid = game.valid_play?(bad_input)

        expect(invalid).to be(false)
      end
    end
  end

  describe '#place_piece' do
    context 'empty board, first play' do
      it 'places piece in row 7' do
        player = game.instance_variable_get(:@player1)
        char = game.place_piece(3, player)

        expect(char).to be(player.player_icon)
      end
    end

    context 'bottom row already has a piece' do
      it 'places the piece in row 6' do
        play = 3
        player = game.instance_variable_get(:@player2)
        board = [%w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 %w[_ _ _ _ _ _ _],
                 ['_', '_', "\u25c6", '_', '_', '_', '_']]
        game.place_piece(play, player, board)

        row_six = game.instance_variable_get(:@board)

        expect(row_six[5][2]).to be("\u25c9")
      end
    end
  end

  describe '#create_piece' do
    let(:new_piece) { instance_double('new_piece') }
    context 'Create a new piece object' do
      it 'creates piece' do
        xcoord = 6
        ycoord = 2
        player = game.instance_variable_get(:@player2)

        allow(new_piece).to receive(:new).and_return("\u25c9")

        piece = game.create_piece(player, xcoord, ycoord)
        expect(piece["#{xcoord}, #{ycoord}"].icon).to be("\u25c9")
      end
    end
  end

  describe '#check_board' do
    context 'returns true if win_check? returns true' do
      before do
        allow(game).to receive(:win_check?).and_return(true)
      end

      it 'returns true' do
        result = game.check_board
        expect(result).to be true
      end
    end

    context 'returns false if win_check? returns false' do
      before do
        allow(game).to receive(:win_check?).and_return(false)
      end

      it 'returns false' do
        result = game.check_board
        expect(result).to be false
      end
    end
  end

  describe '#win_check?' do
    context 'no win condition is present' do
      it 'returns false' do
        xcoord = 6
        ycoord = 2
        player = game.instance_variable_get(:@player2)
        piece = game.create_piece(player, xcoord, ycoord)
        result = game.win_check?(piece['6, 2'])
        expect(result).to be false
      end

      # create winning condition check
      context 'win condition is present' do
        before do
          xcoord = 6
          ycoord = 0
          player = game.instance_variable_get(:@player2)
          game.create_piece(player, xcoord, ycoord += 1) until ycoord == 4
        end

        it 'returns true' do
          xcoord = 6
          ycoord = 0
          player = game.instance_variable_get(:@player2)
          piece = game.create_piece(player, xcoord, ycoord)

          result = game.win_check?(piece['6, 0'])
          expect(result).to be true
        end
      end
    end
  end
end
