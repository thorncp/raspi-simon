require_relative "led"
require_relative "button"
require_relative "game"

game = Game.new(
  [{
    led: Led.new(25),
    button: Button.new(22)
  },
  {
    led: Led.new(24),
    button: Button.new(27)
  },
  {
    led: Led.new(23),
    button: Button.new(17)
  },
  {
    led: Led.new(18),
    button: Button.new(4)
  }])

at_exit do
  game.leds.each { |l| l.off }
end

game.pairs.each do |pair|
  button = pair[:button]
  led = pair[:led]
  button.pushed do
    if game.player_turn?
      led.on
      game.pressed(button)
    end
  end
  button.released { led.off if game.player_turn? }
end

puts "alive..."

game.start

loop do
  game.next_round
  game.show_pattern
  game.player_turn
end
