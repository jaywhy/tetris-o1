# game_over_state.rb

require_relative 'game_state'

class GameOverState < GameState
  def initialize(context)
    super(context)
    @ui = context.ui
  end

  def draw
    @ui.draw_board(@context.board)
    @ui.draw_panel(@context.score, @context.level, @context.next_piece)
    @ui.draw_game_over_screen(@context.score)
  end

  def button_down(id)
    unless [Gosu::MS_LEFT, Gosu::MS_RIGHT].include?(id)
      @context.change_state(StartState.new(@context))
    end
  end
end
