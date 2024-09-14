# ui.rb

require_relative 'constants'

class UI
  attr_accessor :selected_level

  def initialize(font_size = 20)
    @font = Gosu::Font.new(font_size)
    @big_font = Gosu::Font.new(40)
    @selected_level = 1
  end

  def draw_text(text, x, y, size = 1, color = Gosu::Color::WHITE)
    font = size == 1 ? @font : @big_font
    font.draw_text(text, x, y, 2, 1.0, 1.0, color)
  end

  def draw_block(x, y, color)
    Gosu.draw_rect(
    x * Constants::BLOCK_SIZE,
    y * Constants::BLOCK_SIZE,
    Constants::BLOCK_SIZE - 1,
    Constants::BLOCK_SIZE - 1,
    color
    )
  end

  def draw_board(board)
    board.grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        draw_block(x, y, cell) if cell
      end
    end
  end

  def draw_piece(piece, x, y)
    piece.blocks.each_with_index do |row, py|
      row.each_with_index do |cell, px|
        draw_block(x + px, y + py, piece.color) if cell == 1
      end
    end
  end

  def draw_panel(score, level, next_piece)
    panel_x = Constants::BOARD_WIDTH * Constants::BLOCK_SIZE

    # Draw panel background
    Gosu.draw_rect(
    panel_x,
    0,
    Constants::PANEL_WIDTH * Constants::BLOCK_SIZE,
    Constants::WINDOW_HEIGHT,
    Gosu::Color.new(0xFF333333)
    )

    # Draw score
    draw_text("Score:", panel_x + 10, 20)
    draw_text("#{score}", panel_x + 10, 50)

    # Draw level
    draw_text("Level:", panel_x + 10, 80)
    draw_text("#{level}", panel_x + 10, 110)

    # Draw "Next" label
    draw_text("Next:", panel_x + 10, 150)

    # Draw next piece
    draw_next_piece(next_piece, panel_x + 10, 180)
  end

  def draw_next_piece(piece, x_offset, y_offset)
    piece.blocks.each_with_index do |row, py|
      row.each_with_index do |cell, px|
        if cell == 1
          Gosu.draw_rect(
          x_offset + px * Constants::BLOCK_SIZE,
          y_offset + py * Constants::BLOCK_SIZE,
          Constants::BLOCK_SIZE - 1,
          Constants::BLOCK_SIZE - 1,
          piece.color
          )
        end
      end
    end
  end

  def draw_start_screen
    # Draw background
    Gosu.draw_rect(0, 0, Constants::WINDOW_WIDTH, Constants::WINDOW_HEIGHT, Gosu::Color::BLACK)

    # Draw title
    draw_text("Ruby Tetris", Constants::WINDOW_WIDTH / 2 - 100, Constants::WINDOW_HEIGHT / 2 - 150, 2)

    # Draw instructions
    draw_text("Select Starting Level:", Constants::WINDOW_WIDTH / 2 - 120, Constants::WINDOW_HEIGHT / 2 - 50)

    # Draw level selector
    levels = (1..10).to_a
    levels.each_with_index do |level, index|
      x = Constants::WINDOW_WIDTH / 2 - 150 + (index % 5) * 60
      y = Constants::WINDOW_HEIGHT / 2 + (index / 5) * 50
      color = level == @selected_level ? Gosu::Color::YELLOW : Gosu::Color::WHITE
      draw_text("#{level}", x, y, 1, color)
    end

    # Draw start instruction
    draw_text("Press Enter to Start", Constants::WINDOW_WIDTH / 2 - 100, Constants::WINDOW_HEIGHT / 2 + 100)
    # Draw quit instruction
    draw_text("Press 'Q' to Quit", Constants::WINDOW_WIDTH / 2 - 80, Constants::WINDOW_HEIGHT / 2 + 130)
  end

  def draw_game_over_screen(score)
    # Overlay transparent black background
    Gosu.draw_rect(0, 0, Constants::WINDOW_WIDTH, Constants::WINDOW_HEIGHT, Gosu::Color.new(0xAA000000))

    # Draw "Game Over" text
    draw_text("Game Over", Constants::WINDOW_WIDTH / 2 - 100, Constants::WINDOW_HEIGHT / 2 - 100, 2)

    # Display final score
    draw_text("Final Score: #{score}", Constants::WINDOW_WIDTH / 2 - 80, Constants::WINDOW_HEIGHT / 2 - 30)

    # Prompt to restart
    draw_text("Press any key to restart", Constants::WINDOW_WIDTH / 2 - 120, Constants::WINDOW_HEIGHT / 2 + 20)
  end

  def draw_pause_screen
    # Draw paused text
    draw_text("Paused", Constants::WINDOW_WIDTH / 2 - 40, Constants::WINDOW_HEIGHT / 2 - 40)
    # Draw unpause instruction
    draw_text("Press 'P' to Resume", Constants::WINDOW_WIDTH / 2 - 100, Constants::WINDOW_HEIGHT / 2 - 10)
    # Draw restart instruction
    draw_text("Press 'R' to Restart", Constants::WINDOW_WIDTH / 2 - 100, Constants::WINDOW_HEIGHT / 2 + 20)
    # Draw quit instruction
    draw_text("Press 'Q' to Quit", Constants::WINDOW_WIDTH / 2 - 80, Constants::WINDOW_HEIGHT / 2 + 50)
  end
end
