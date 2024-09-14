# constants.rb

module Constants
  BLOCK_SIZE = 30
  BOARD_WIDTH = 10   # Standard Tetris board width
  BOARD_HEIGHT = 20  # Standard Tetris board height
  PANEL_WIDTH = 6    # Width of the side panel in blocks
  WINDOW_WIDTH = (BOARD_WIDTH + PANEL_WIDTH) * BLOCK_SIZE
  WINDOW_HEIGHT = BOARD_HEIGHT * BLOCK_SIZE

  SHAPES = {
  i: [[1, 1, 1, 1]],
  o: [[1, 1], [1, 1]],
  t: [[0, 1, 0], [1, 1, 1]],
  s: [[0, 1, 1], [1, 1, 0]],
  z: [[1, 1, 0], [0, 1, 1]],
  j: [[1, 0, 0], [1, 1, 1]],
  l: [[0, 0, 1], [1, 1, 1]]
  }

  COLORS = {
  i: Gosu::Color::CYAN,
  o: Gosu::Color::YELLOW,
  t: Gosu::Color::FUCHSIA,
  s: Gosu::Color::GREEN,
  z: Gosu::Color::RED,
  j: Gosu::Color::BLUE,
  l: Gosu::Color.new(0xFFFFA500) # Custom orange color for 'l' shape
  }

  INITIAL_DROP_INTERVAL = 500  # Initial drop speed in milliseconds
end
