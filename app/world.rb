# frozen_string_literal: true

class World
  def initialize(height, width)
    @cells = []
    height.times do |x|
      @cells.push([])
      width.times do |y|
        @cells[x].push(Cell.new(self, x, y))
      end
    end
  end

  def cells
    @cells.flatten
  end

  def cell_at(x, y)
    return unless @cells[x]

    @cells[x][y]
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
