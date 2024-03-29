# frozen_string_literal: true

require 'app/world'

SIZE    = 6
PADDING = SIZE * 2

BLACK = { r: 0, g: 0, b: 0, a: 0 }.freeze
WHITE = { r: 255, g: 255, b: 255 }.freeze

def tick(args)
  init(args) if args.state.tick_count.zero?

  args.outputs.background_color = BLACK

  cells = args.state.world.cells

  args.outputs.solids << cells.map do |y, x|
    { x: x * SIZE + PADDING, y: y * SIZE + PADDING, w: SIZE - 1, h: SIZE - 1, **WHITE }
  end

  txt = <<~STR
    Ticks: #{args.state.tick_count} |
    FPS: #{args.gtk.current_framerate.round} |
    CELLS: #{cells.size} of #{args.state.world.stats[:born]}
    (#{args.state.world.stats[:max]})
  STR

  args.outputs.labels << {
    text: txt,
    x: 10.from_right,
    y: 10.from_top,
    alignment_enum: 2,
    size_enum: 0
  }.merge(WHITE)

  args.state.world.next_generation! # if args.state.tick_count.mod_zero?(20)
end

def init(args)
  world_w = (args.grid.w - PADDING * 2).div(SIZE)
  world_h = (args.grid.h - PADDING * 2).div(SIZE)

  args.state.world = World.new(world_w, world_h)
  args.state.world.day1!
end
