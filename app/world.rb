# frozen_string_literal: true

class World
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
    n = []

    -1.upto(1) do |y_|
      -1.upto(1) do |x_|
        next if y_.zero? && x_.zero? # ignore self

        n << @map[y + y_][x + x_] if @map[y + y_] && @map[y + y_][x + x_] == 1
      end
    end

    n
  end

  def day1!
    @count.times do
      x = rand(@width)
      y = rand(@height)

      @map[y][x] = 1
    end
  end

  def cells
    cells = []

    0.upto(@height - 1) do |y|
      0.upto(@width - 1) do |x|
        cells << [y, x] if @map[y][x] == 1
      end
    end

    cells
  end

  def next_generation!
    new_map = empty_map

    dead = 0
    born = 0

    0.upto(@height - 1) do |y|
      0.upto(@width - 1) do |x|
        cell = @map[y][x]

        neighbours = neighbours_at(x, y).length

        if cell == 1 && (neighbours < 2 || neighbours > 3)
          new_map[y][x] = 0 # die
          dead += 1
        elsif cell == 0 && neighbours == 3
          new_map[y][x] = 1 # born
          born += 1
        else # keep as is
          new_map[y][x] = cell
        end
      end
    end

    @map = new_map
  end
end
