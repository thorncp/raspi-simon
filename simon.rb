require_relative "led"
require_relative "button"

game = {
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
  }
}

at_exit do
  game.each do |_, stuff|
    stuff[:led].off
  end
end

game.each do |color, stuff|
  stuff[:button].pushed do
    stuff[:led].toggle
  end
end

puts "alive..."

things = 0

loop do
  things += 1
  pattern = things.times.map { game.keys.sample }
  p pattern

  pattern.each do |color|
    stuff = game[color]
    stuff[:led].on
    sleep 1
    stuff[:led].off
    sleep 1
  end
end

# PiPiper.wait
