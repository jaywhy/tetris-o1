# tetris_game.rb

require 'gosu'
require_relative 'constants'
require_relative 'piece'
require_relative 'board'
require_relative 'ui'
require_relative 'game_state'
require_relative 'start_state'
require_relative 'playing_state'
require_relative 'paused_state'
require_relative 'game_over_state'

class TetrisGame < Gosu::Window
  attr_accessor :ui, :music, :board, :score, :level, :drop_interval, :key_repeat_delay, :key_repeat_interval
  attr_accessor :current_piece, :next_piece, :current_x, :current_y, :last_drop_time

  def initialize
    super Constants::WINDOW_WIDTH, Constants::WINDOW_HEIGHT
    self.caption = "Ruby Tetris"

    @ui = UI.new
    @music = Gosu::Song.new("tetris_theme.mp3") # Replace with your music file
    @music.volume = 0.5                         # Set volume (0.0 to 1.0)
    @music.play(true)                           # Play the song in a loop

    @key_repeat_delay = 200        # Initial delay before repeating (milliseconds)
    @key_repeat_interval = 100     # Interval between repeats (milliseconds)

    @state = nil
    change_state(StartState.new(self))
  end

  def change_state(new_state)
    @state.exit if @state
    @state = new_state
    @state.enter
  end

  def reset_game
    @board = Board.new
    @score = 0
    @level = @ui.selected_level
    @drop_interval = Constants::INITIAL_DROP_INTERVAL - (@level - 1) * 50
    @drop_interval = [@drop_interval, 100].max

    # Initialize current and next pieces
    @current_piece = nil
    @next_piece = nil
    spawn_piece
    @last_drop_time = Gosu.milliseconds
  end

  def update
    @state.update if @state
  end

  def draw
    @state.draw if @state
  end

  def button_down(id)
    @state.button_down(id) if @state
  end

  def button_up(id)
    @state.button_up(id) if @state
  end

  # Methods used by states

  def spawn_piece
    if @next_piece
      @current_piece = @next_piece
    else
      @current_piece = Piece.new
    end

    @next_piece = Piece.new

    @current_x = (Constants::BOARD_WIDTH / 2) - (@current_piece.blocks[0].size / 2)
    @current_y = 0
  end

  def move_piece(dx, dy)
    if @board.valid_position?(@current_piece, @current_x + dx, @current_y + dy)
      @current_x += dx
      @current_y += dy
    end
  end

  def move_piece_down
    if @board.valid_position?(@current_piece, @current_x, @current_y + 1)
      @current_y += 1
    else
      @board.place_piece(@current_piece, @current_x, @current_y)
      lines_cleared = @board.clear_lines

      update_score_and_level(lines_cleared) if lines_cleared > 0

      spawn_piece
      unless @board.valid_position?(@current_piece, @current_x, @current_y)
        @music.pause
        change_state(GameOverState.new(self))
      end
    end
  end

  def rotate_piece
    @current_piece.rotate
    unless @board.valid_position?(@current_piece, @current_x, @current_y)
      # Try wall kicks (not implemented)
      @current_piece.rotate  # Rotate back if not valid
      @current_piece.rotate
      @current_piece.rotate
    end
  end

  def update_score_and_level(lines_cleared)
    # Update score based on the number of lines cleared and current level
    case lines_cleared
    when 1
      @score += 100 * @level
    when 2
      @score += 300 * @level
    when 3
      @score += 500 * @level
    when 4
      @score += 800 * @level
    end

    # Check if level should increase
    new_level = (@board.lines_cleared_total / 10) + @ui.selected_level
    if new_level > @level
      @level = new_level
      # Increase speed
      # Decrease drop interval but not less than 100ms
      @drop_interval = [@drop_interval - 50, 100].max
    end
  end
end

TetrisGame.new.show
