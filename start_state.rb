# start_state.rb

require_relative 'game_state'
require_relative 'playing_state'  # Ensure this is required for the transition

class StartState < GameState
  def initialize(context)
    super(context)
    @ui = context.ui
  end

  def draw
    @ui.draw_start_screen
  end

  def button_down(id)
    case id
    when Gosu::KB_RETURN, Gosu::KB_ENTER
      @context.reset_game  # Reset the game before starting
      @context.change_state(PlayingState.new(@context))
    when Gosu::KB_LEFT
      @ui.selected_level -= 1
      @ui.selected_level = 1 if @ui.selected_level < 1
    when Gosu::KB_RIGHT
      @ui.selected_level += 1
      @ui.selected_level = 10 if @ui.selected_level > 10
    when Gosu::KB_Q
      @context.close  # Close the game window
    else
      # Do nothing for other keys
    end
  end
end
