# frozen-string-literal: true

require_relative 'players'

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
    @player1 = new_player
  end

  def new_player
    Player.new
  end
end
