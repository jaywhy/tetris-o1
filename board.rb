# board.rb

require_relative "constants"

class Board
  attr_reader :grid, :lines_cleared_total

  def initialize
    @grid = Array.new(Constants::BOARD_HEIGHT) { Array.new(Constants::BOARD_WIDTH, nil) }
    @lines_cleared_total = 0
  end

  def valid_position?(piece, x, y)
    piece.blocks.each_with_index do |row, py|
      row.each_with_index do |cell, px|
        next unless cell == 1

        new_x = x + px
        new_y = y + py
        return false if new_x.negative? || new_x >= Constants::BOARD_WIDTH || new_y >= Constants::BOARD_HEIGHT
        return false if @grid[new_y][new_x]
      end
    end
    true
  end

  def place_piece(piece, x, y)
    piece.blocks.each_with_index do |row, py|
      row.each_with_index do |cell, px|
        @grid[y + py][x + px] = piece.color if cell == 1
      end
    end
  end

  def clear_lines
    lines_cleared = 0

    @grid.each_with_index do |row, y|
      next unless row.all?

      @grid.delete_at(y)
      @grid.unshift(Array.new(Constants::BOARD_WIDTH, nil))
      lines_cleared += 1
    end

    @lines_cleared_total += lines_cleared
    lines_cleared
  end
end
