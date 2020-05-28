# frozen_string_literal: true

# Board where the game is played on
class Board
  def initialize
    @grid = build_grid
  end

  def valid_move?(move)
    return false if move.nil?

    if @grid[move].empty?
      true
    else
      false
    end
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
    empty_cells = @grid.map.with_index do |cell, index|
      index if cell.empty?
    end.compact
  end

  def prepare_for_display
    @grid.map do |cell|
      if cell.empty?
        ' '
      else
        cell
      end
    end
  end

  def show
    grid = prepare_for_display
    puts <<~HEREDOC
      #{grid[0]}|#{grid[1]}|#{grid[2]}
      -+-+-
      #{grid[3]}|#{grid[4]}|#{grid[5]}
      -+-+-
      #{grid[6]}|#{grid[7]}|#{grid[8]}
    HEREDOC

    puts
  end

  private

  def build_grid
    Array.new(9, '')
  end
end
