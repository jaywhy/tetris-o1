# playing_state.rb

require_relative 'game_state'
require_relative 'paused_state'

class PlayingState < GameState
  def initialize(context)
    super(context)
    @ui = context.ui
    @keys_pressed = {}
  end

  def update
    if Gosu.milliseconds - @context.last_drop_time > @context.drop_interval
      @context.move_piece_down
      @context.last_drop_time = Gosu.milliseconds
    end

    handle_input
  end

  def draw
    @ui.draw_board(@context.board)
    @ui.draw_piece(@context.current_piece, @context.current_x, @context.current_y)
    @ui.draw_panel(@context.score, @context.level, @context.next_piece)
  end

  def button_down(id)
    case id
    when Gosu::KB_LEFT, Gosu::KB_RIGHT, Gosu::KB_DOWN
      process_key(id)
      @keys_pressed[id] = { last_time: Gosu.milliseconds, count: 0 }
    when Gosu::KB_UP
      @context.rotate_piece
    when Gosu::KB_P, Gosu::KB_SPACE
      @context.change_state(PausedState.new(@context))
    end
  end

  def button_up(id)
    @keys_pressed.delete(id)
  end

  private

  def handle_input
    @keys_pressed.each do |key, data|
      delay = data[:count] == 0 ? @context.key_repeat_delay : @context.key_repeat_interval
      if Gosu.milliseconds - data[:last_time] > delay
        process_key(key)
        @keys_pressed[key][:last_time] = Gosu.milliseconds
        @keys_pressed[key][:count] += 1
      end
    end
  end

  def process_key(key)
    case key
    when Gosu::KB_LEFT
      @context.move_piece(-1, 0)
    when Gosu::KB_RIGHT
      @context.move_piece(1, 0)
    when Gosu::KB_DOWN
      @context.move_piece_down
    end
  end
end
