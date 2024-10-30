require_relative 'lib/cell'
require 'rspec'
require_relative 'lib/ship'
require_relative 'lib/board'
require_relative 'lib/game'
require 'pry'

game = Game.new("Cam")
game.start