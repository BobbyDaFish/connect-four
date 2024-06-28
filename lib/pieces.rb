# frozen-string-literal: true

# Nodes that contain the coordinates of that played piece, and it's neighbor coordinates
class Pieces
  attr_reader :icon, :coords, :neighbors

  def initialize(player, xcoord, ycoord)
    @icon = player.player_icon
    @coords = [[xcoord][ycoord]]
    @neighbors = [[xcoord - 1][ycoord - 1],
                  [xcoord - 1][ycoord],
                  [xcoord - 1][ycoord + 1],
                  [xcoord][ycoord + 1]]
  end
end
