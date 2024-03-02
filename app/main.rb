# frozen_string_literal: true

require 'app/world'

SIZE    = 3
PADDING = SIZE * 2

BLACK = { r: 0, g: 0, b: 0 }.freeze
WHITE = { r: 255, g: 255, b: 255, a: 150 }.freeze
RED   = { r: 255, g: 20, b: 20 }.freeze
GREEN = { r: 20, g: 255, b: 20 }.freeze

def tick(args)
  init(args) if args.state.tick_count.zero?

  args.outputs.background_color = BLACK

  cells = args.state.world.cells

  args.outputs.solids << cells.map do |y, x|
    { x: x * SIZE + PADDING, y: y * SIZE + PADDING, w: SIZE - 1, h: SIZE - 1, **WHITE }
  end

  args.outputs.labels << {
    text: "Ticks: #{args.state.tick_count} | FPS: #{args.gtk.current_framerate.round} | CELLS: #{cells.size} of #{args.state.world.stats[:born]} (#{args.state.world.stats[:max]})",
    x: 10.from_right,
    y: 10.from_top,
    alignment_enum: 2,
    size_enum: 0
  }.merge(WHITE)

  args.state.world.next_generation! # if args.state.tick_count.mod_zero?(20)
end

def bg(args, color: BLACK)
  args.outputs.solids << { x: args.grid.left, y: args.grid.bottom, w: args.grid.w, h: args.grid.h, **color }
end

def init(args)
  args.state.world = World.new((1280 - PADDING * 2).div(SIZE), (720 - PADDING * 2).div(SIZE))
  args.state.world.day1!
end
