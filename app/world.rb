# frozen_string_literal: true

class World
  class Map
    OFFSETS = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ].freeze

    attr_reader :cells

    def initialize(w, h)
      @storage    = Array.new(h) { Array.new(w, 0) }
      @neighbours = Array.new(h) { Array.new(w, 0) }
      @cells      = []
    end

    def [](y, x)
      @storage[y][x]
    end

    def []=(y, x, val)
      @storage[y][x] = val

      @cells << [y, x]
      bump_neighbours(y, x)
    end

    def alive_neighbours_at(x, y)
      @neighbours[y][x]
    end

    def bump_neighbours(y, x)
      OFFSETS.each { |oy, ox| @neighbours[y + oy][x + ox] += 1 }
    end
  end

  def initialize(width, height, count: (width * height).div(3))
    @count       = count
    @width       = width
    @height      = height
    @map         = empty_map
    @populations = []
  end

  def stuck?
    return if @populations.size < 5

    @populations.all? { |count| count == @populations[0] }
  end

  def stats
    { max: @width * @height, born: @count }
  end

  def cells
    @map.cells
  end

  def empty_map
    Map.new(@width, @height)
  end

  def day1!
    @count.times { @map[rand(@height - 2) + 1, rand(@width - 2) + 1] = 1 }
  end

  def next_generation!
    return if stuck?

    new_map = empty_map

    1.upto(@height - 2) do |y|
      1.upto(@width - 2) do |x|
        neighbours = @map.alive_neighbours_at(x, y)

        new_map[y, x] = 1 if @map[y, x] == 1 && (neighbours == 2 || neighbours == 3) || neighbours == 3
      end
    end

    @map = new_map

    @populations << cells.size
    @populations.shift if @populations.size > 5
  end
end
