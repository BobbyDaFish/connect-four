# frozen-string-literal: true

require_relative 'players'
require_relative 'pieces'

# class to contain game board, and verticies for piece graphs.
class Game
  def initialize
    @board = [%w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _]]
    @player1 = new_player(1)
    @player2 = new_player(2)
  end

  def new_player(player_num)
    Player.new(player_num)
  end

  def display_board
    puts '1 2 3 4 5 6 7'
    i = 0
    until i == 7
      puts @board[i].join(' | ')
      i += 1
    end
  end

  def valid_play?(play, board = @board)
    return play if play.match?(/[1-7]/)
    return play if board[0][play - 1] == '_'

    false
  end

  def get_play(player)
    puts 'Select a column between 1 and 7 that is not full to place your piece'
    input = 0
    loop do
      input = gets.chomp.to_i
      break if valid_play?(input)

      puts 'Invalid selection. Select a column between 1 and 7 that is not full to place your piece.'
    end
    place_piece(input, player)
  end

  def place_piece(input, player, board = @board)
    i = 1 # will always start with second row, as valid_input? checks if top row is full
    loop do
      break if i == 7 # we've reached the bottom, row 8 doesn't exist.
      break if board[i][input - 1] != '_'

      i += 1
    end
    @board[i - 1][input - 1] = player.player_icon
  end
end
