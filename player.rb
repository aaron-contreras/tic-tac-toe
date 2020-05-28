# frozen_string_literal: true

# Players required to play a game
class Player
  attr_reader :piece, :name

  def initialize(player_info)
    @name = player_info[0]
    @piece = player_info[1]
    @turn = false
    @moves = []
  end

  def turn?
    @turn
  end

  def move(board); end

  def self.ai?
    true
  end

  def add_move_to_list(move)
    @moves.push(move)
  end

  private

  def missing_one?(board, win_conditions)
  end
end
