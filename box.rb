class Box
  attr_accessor :width, :height, :character

  def initialize(width, height, character)
    @width = width
    @height = height
    @character = character
  end

  def fill(character)
    Box.new(@width, @height, character)
  end

  def print
    box_line = ''
    puts "\n#{@width} by #{@height} box filled with #{@character} character:"

    @width.times do
      box_line << @character
    end

    @height.times do
      puts box_line
    end

    self
  end

  def expand(times)
    Box.new(width * times, height * times, @character)
  end

  def resize(new_width, new_height)
    Box.new(new_width, new_height, @character)
  end

  def rotate
    Box.new(@height, @width, @character)
  end
end

box = Box.new(10, 3, '0')
          .print
          .expand(2)
          .print
          .resize(3, 10)
          .fill('#')
          .print
          .rotate
          .print