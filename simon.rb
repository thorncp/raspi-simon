require_relative "led"
require_relative "button"
require_relative "game"

game = Game.new(
  red: {
  led: Led.new(25),
  button: Button.new(22)
},
  green: {
  led: Led.new(24),
  button: Button.new(17)
},
  blue: {
  led: Led.new(23),
  button: Button.new(4)
})

at_exit do
  game.leds.each { |l| l.off }
end

game.pairs.each do |led, button|
  button.pushed { led.toggle }
end

puts "alive..."

game.start

loop do
  game.next_round
  p game.current_round.pattern
  game.show_pattern
end
