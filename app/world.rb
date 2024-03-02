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

  def alive_neighbours_at(x, y)
    OFFSETS.count { |offset_y, offset_x| @map[y + offset_y][x + offset_x] == 1 }
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

    1.upto(@height - 2) do |y|
      1.upto(@width - 2) do |x|
        alive = @map[y][x] == 1

        neighbours = alive_neighbours_at(x, y)

        if alive && (neighbours == 2 || neighbours == 3) || neighbours == 3
          new_map[y][x] = 1
          @cells << [y, x]
        end
      end
    end

    @map = new_map
  end
end
