require 'pry'
class Board
  def initialize
    @grid = build_grid
  end

  def valid_move? move
    return false if move == nil

    if grid[move].empty?
      true
    else
      false
    end
  end

  def update_grid player, move
   grid[move] = player.piece 
  end

  def filled?
    @grid.none? {|cell| cell.empty?}
  end

  def cell_at index
    @grid[index]
  end

  def update_display
    p grid
  end

  def show
    puts
    3.times do |outer_index|
      row_output = ""
      3.times do |inner_index|
        cell = outer_index * 3 + inner_index
        if grid[cell].empty?
          row_output << " "
        else
          row_output << grid[cell]
        end
        row_output << "|" unless inner_index == 2
      end
      puts row_output
      unless outer_index == 2
        horizontal_dividers = ""
        5.times {horizontal_dividers << "-"}
        puts horizontal_dividers
        horizontal_dividers = ""
      end
    end
    puts
  end

  private
  def build_grid
    Array.new(9, '')
  end

  attr_accessor :grid
end