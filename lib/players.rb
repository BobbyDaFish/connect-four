# frozen-string-literal: true

class Player
  def initialize(player_num)
    @player_icon = if player_num == 1
                     "\u25c6"
                   else
                     "\u25c9"
                   end
  end
end
