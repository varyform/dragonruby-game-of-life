# frozen_string_literal: true

class World
  attr_reader :cells

  OFFSETS = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ].freeze

  def initialize(width, height, count: 5000)
    @cells   = []
    @count   = count
    @width   = width
    @height  = height
    @map     = empty_map
  end

  def empty_map
    Array.new(@height) { Array.new(@width, 0) }
  end

  def neighbours_at(x, y)
    OFFSETS.count do |offset_y, offset_x|
      @map[y + offset_y][x + offset_x] == 1 if @map[y + offset_y] && @map[y + offset_y][x + offset_x]
    end
  end

  def day1!
    @count.times do
      x = rand(@width)
      y = rand(@height)

      @map[y][x] = 1
      @cells << [y, x]
    end
  end

  def next_generation!
    new_map = empty_map
    @cells = []

    0.upto(@height - 1) do |y|
      0.upto(@width - 1) do |x|
        cell = @map[y][x]

        neighbours = neighbours_at(x, y)

        if cell == 1 && (neighbours < 2 || neighbours > 3)
          new_map[y][x] = 0 # die
        elsif cell == 0 && neighbours == 3
          new_map[y][x] = 1 # born
          @cells << [y, x]
        else # keep as is
          new_map[y][x] = cell
          @cells << [y, x] if cell == 1 # only alive
        end
      end
    end

    @map = new_map
  end
end
