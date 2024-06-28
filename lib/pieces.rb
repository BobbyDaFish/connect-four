# frozen-string-literal: true

# Nodes that contain the coordinates of that played piece, and it's neighbor coordinates
class Pieces
  def initialize(player, coords)
    @icon = player.player_icon
    @coords = coords
    @neighbors = [[coords[0] - 1][coords[1] - 1],
                  [coords[0] - 1][coords[1]],
                  [coords[0] - 1][coords[1] + 1],
                  [coords[0]][coords[1] + 1]]
  end
end
