class Player
  def initialize player_info
    @name = player_info[0]
    @piece = player_info[1]
    @turn = false
  end

  def turn?
    @turn
  end

  attr_reader :piece, :name
end