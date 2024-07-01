# frozen-string-literal: true

require_relative 'players'
require_relative 'pieces'
require 'pry-byebug'

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
    @pieces = {}
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
    return play if play.to_s.match?(/[1-7]/) && board[0][play - 1] == '_'

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
    create_piece(player, i - 1, input - 1)
    @board[i - 1][input - 1] = player.player_icon
    @board[i - 1][input - 1]
  end

  def create_piece(player, xcoord, ycoord)
    @pieces.merge!({ "#{xcoord}, #{ycoord}" => Pieces.new(player, xcoord, ycoord) })
  end

  # returns true if a win condition is found, false if no win condition is found
  def check_board
    xcoord = 6
    ycoord = 0
    while ycoord < 4 && xcoord.positive?
      piece_check = @pieces["#{xcoord}, #{ycoord}"] if @pieces.key?("#{xcoord}, #{ycoord}")
      return true if win_check?(piece_check)

      ycoord += 1
      ycoord = 0 && xcoord += 1 if ycoord == 7

    end
    false
  end

  def win_check?(piece, score = 1, direction = nil)
    icon = piece.icon
    coords = piece.coords
    neighbors = piece.neighbors
    if direction.nil?
      neighbors.each do |n_coords|
        next unless @pieces.key?("#{n_coords[0]}, #{n_coords[1]}")

        next_piece = @pieces["#{n_coords[0]}, #{n_coords[1]}"]
        next unless next_piece.icon == icon

        return win_check?(next_piece, score += 1, [coords[0] - n_coords[0], coords[1] - n_coords[1]])
      end
    elsif @pieces.key?("#{coords[0] - direction[0]}, #{coords[1] - direction[1]}")
      # when given a direction set as an array ex [-1, 0] use it to do a single check for matching icon.
      next_piece = @pieces["#{coords[0] - direction[0]}, #{coords[1] - direction[1]}"]
      return false unless next_piece.icon == icon

      score += 1
      return true if score == 4

      return win_check?(next_piece, score, direction)
    end
    false
  end
end
