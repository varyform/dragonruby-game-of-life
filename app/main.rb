# frozen_string_literal: true

require 'app/cell'
require 'app/world'

SIZE = 8
PADDING = SIZE * 2
BLACK = { r: 0, g: 0, b: 0 }.freeze
WHITE = { r: 255, g: 255, b: 255 }.freeze

def tick(args)
  init(args) if args.state.tick_count.zero?

  bg(args)

  args.state.world.cells.select(&:live?).each do |cell|
    args.outputs.solids << { x: cell.x * SIZE + PADDING, y: cell.y * SIZE + PADDING, w: SIZE, h: SIZE }.merge(WHITE)
  end

  args.outputs.labels << {
    text: "Ticks: #{args.state.tick_count} | FPS: #{args.gtk.current_framerate.round}",
    x: 10.from_right,
    y: 10.from_top,
    alignment_enum: 2,
    size_enum: 0
  }.merge(WHITE)

  args.state.world.next_generation!
end

def bg(args, color: BLACK)
  args.outputs.solids << { x: args.grid.left, y: args.grid.bottom, w: args.grid.w, h: args.grid.h }.merge(color)
end

def init(args)
  args.state.world = World.new((1280 - PADDING * 2).div(SIZE), (720 - PADDING * 2).div(SIZE))
end
