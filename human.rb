# frozen_string_literal: true

require_relative './player.rb'
# User controlled player
class Human < Player
  def move(board)
    move = nil

    until board.valid_move? move
      possible_move = gets.chomp
      move = possible_move.to_i if possible_move.between?('0', '8')
    end

    move
  end
end
