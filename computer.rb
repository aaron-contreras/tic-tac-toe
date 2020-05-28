# frozen_string_literal: true

require_relative './player.rb'
# Player controlled by A.I.
class Computer < Player
  LEVELS = ['not much', 'very', 'genius'].freeze

  def initialize(player_info)
    super (player_info.first 2)
    @intelligence = player_info.last
  end

  def self.intelligence_level
    intelligence = gets.chomp until LEVELS.include? intelligence
    intelligence
  end

  def move(board)
    move = nil

    until board.valid_move? move
      possible_move = gets.chomp
      move = possible_move.to_i if possible_move.between?('0', '8')
    end

    move
  end
end
