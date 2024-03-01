class Cell
  attr_reader :world, :x, :y

  def initialize(world, x, y)
    @world = world
    @x = x
    @y = y
    @live = rand < 0.1
  end

  def dead?
    !@live
  end

  def dead!
    @live = false
  end

  def live?
    @live
  end

  def live!
    @live = true
  end

  def toggle!
    @live = !@live
  end

  def neighbours
    neighbours = []
    neighbours.push(@world.cell_at(x - 1, y - 1))
    neighbours.push(@world.cell_at(x - 1, y))
    neighbours.push(@world.cell_at(x - 1, y + 1))

    neighbours.push(@world.cell_at(x, y - 1))
    neighbours.push(@world.cell_at(x, y + 1))

    neighbours.push(@world.cell_at(x + 1, y - 1))
    neighbours.push(@world.cell_at(x + 1, y))
    neighbours.push(@world.cell_at(x + 1, y + 1))

    neighbours
  end

  def live_neighbours
    neighbours.select { |n| n&.live? }
  end
end
