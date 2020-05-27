# frozen_string_literal: true

# Board where the game is played on
class Board
  def initialize(mode)
    @grid = build_grid mode
  end

  def valid_move?(move)
    return false if move.nil?

    if grid[move].empty?
      true
    else
      false
    end
  end

  def update_grid(player, move)
    grid[move] = player.piece
  end

  def filled?
    @grid.none?(&:empty?)
  end

  def cell_at(index)
    @grid[index]
  end

  def print_moves(built_string, row)
    3.times do |inner_index|
      cell = row * 3 + inner_index

      built_string += if grid[cell].empty?
                        ' '
                      else
                        grid[cell]
                      end

      built_string += '|' unless inner_index == 2
    end

    built_string
  end

  def print_dividers
    horizontal_dividers = ''
    5.times { horizontal_dividers += '-' }
    puts horizontal_dividers
  end

  def show
    puts

    3.times do |outer_index|
      row_output = ''
      row_output += print_moves row_output, outer_index
      puts row_output

      next if outer_index == 2

      print_dividers
    end

    puts
  end

  private

  def build_grid(mode)
    if mode == :playing
      Array.new(9, '')
    else
      Array.new(9, &:to_s)
    end
  end
  attr_accessor :grid
end
