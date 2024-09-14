# piece.rb

require_relative 'constants'

class Piece
  attr_reader :shape, :color, :blocks

  def initialize(shape_key = nil)
    @shape_key = shape_key || Constants::SHAPES.keys.sample
    @shape = Constants::SHAPES[@shape_key]
    @color = Constants::COLORS[@shape_key]
    @blocks = @shape.map(&:dup)
  end

  def rotate
    @blocks = @blocks.transpose.map(&:reverse)
  end

  def reset_rotation
    @blocks = @shape.map(&:dup)
  end
end
