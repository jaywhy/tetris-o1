# paused_state.rb

require_relative 'game_state'
require_relative 'playing_state'

class PausedState < GameState
  def initialize(context)
    super(context)
    @ui = context.ui
  end

  def enter
    @context.music.pause
  end

  def exit
    @context.music.play(true)
  end

  def update
    # No updates while paused
  end

  def draw
    # Draw the game as it was, plus the pause overlay
    @ui.draw_board(@context.board)
    @ui.draw_piece(@context.current_piece, @context.current_x, @context.current_y)
    @ui.draw_panel(@context.score, @context.level, @context.next_piece)
    @ui.draw_pause_screen
  end

  def button_down(id)
    case id
    when Gosu::KB_P, Gosu::KB_SPACE
      # Unpause the game
      @context.change_state(PlayingState.new(@context))
    when Gosu::KB_Q
      @context.close  # Close the game window
    when Gosu::KB_R
      # Restart the game
      @context.reset_game
      @context.change_state(PlayingState.new(@context))
    else
      # Ignore other inputs while paused
    end
  end

  def button_up(id)
    # Do nothing
  end
end
