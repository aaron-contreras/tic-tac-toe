# frozen_string_literal: true

# Board where the game is played on
class Board
  def initialize
    @grid = build_grid
  end

  def valid_move?(move)
    return false unless move.between?(0, 8)

    @grid[move].empty?
  end

  def update_grid(player, move)
    @grid[move] = player.piece
  end

  def filled?
    @grid.none?(&:empty?)
  end

  def cell_at(index)
    @grid[index]
  end

  def empty_cells
    @grid.each_index.select do |cell|
      @grid[cell].empty?
    end
  end

  def center_empty?
    cell_at(4).empty?
  end

  def opposite_empty?(corner)
    return corner if corner.nil?

    cell_at(corner).empty?
  end

  def find_first_empty(move_set)
    move_set.find { |move| @grid[move].empty? }
  end

  def empty_corner(corner_moves)
    find_first_empty(corner_moves)
  end

  def empty_side(side_moves)
    find_first_empty(side_moves)
  end

  def show
    grid = prepare_for_display
    puts <<~HEREDOC

       #{grid[0]} | #{grid[1]} | #{grid[2]} 
      ---+---+---
       #{grid[3]} | #{grid[4]} | #{grid[5]} 
      ---+---+---
       #{grid[6]} | #{grid[7]} | #{grid[8]} 

    HEREDOC
  end

  private

  def prepare_for_display
    @grid.map.with_index do |cell, index|
      if cell.empty?
        index
      else
        cell
      end
    end
  end

  def build_grid
    Array.new(9, '')
  end
end
