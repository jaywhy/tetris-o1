# game_state.rb

class GameState
  def initialize(context)
    @context = context
  end

  def enter; end  # Called when entering the state
  def exit; end   # Called when exiting the state

  def update; end
  def draw; end
  def button_down(id); end
  def button_up(id); end
end
