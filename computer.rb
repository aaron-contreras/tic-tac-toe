# frozen_string_literal: true

# Player controlled by A.I.
require_relative './player.rb'
class Computer < Player
  def initialize(player_info, difficulty)
    super player_info
    @difficulty = difficulty
  end
end