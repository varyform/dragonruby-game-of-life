# frozen_string_literal: true

class World
  def initialize(width, height, count: 100)
    @cells  = []
    @count  = count
    @width  = width
    @height = height
  end

  def cells
    @cells.flatten
  end

  def cell_at(x, y)
    return unless @cells[x]

    @cells[x][y]
  end

  def day1!
    @count.times do
      x = rand(@width)
      y = rand(@height)

      @cells << Cell.new(self, x, y)
    end
  end

  def next_generation!
    affected = []

    cells.each do |cell|
      neighbours = cell.live_neighbours.length

      if cell.live? && (neighbours < 2 || neighbours > 3)
        affected.push cell
      elsif cell.dead? && neighbours == 3
        affected.push cell
      end
    end

    affected.each(&:toggle!)
  end
end
