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
  round = game.next_round

  p round.pattern
  round.pattern.each do |color|
    led = game.led_for(color)
    led.on
    sleep 1
    led.off
    sleep 1
  end
end
