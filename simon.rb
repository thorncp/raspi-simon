require "pi_piper"

include PiPiper

red_led = PiPiper::Pin.new(pin: 25, direction: :out)
green_led = PiPiper::Pin.new(pin: 24, direction: :out)
blue_led = PiPiper::Pin.new(pin: 23, direction: :out)

at_exit do
  red_led.off
  green_led.off
  blue_led.off
end

red_button = 22
green_button = 17
blue_button = 4

colors = [:red, :green, :blue].freeze

colors.each do |color|
  button = eval("#{color}_button")
  led = eval("#{color}_led")

  after pin: button, goes: :low do
    led.read
    if led.on?
      led.off
    else
      led.on
    end
  end
end

puts "alive..."

things = 0

loop do
  things += 1
  pattern = things.times.map { colors.sample }
  p pattern

  pattern.each do |color|
    led = eval("#{color}_led")
    led.on
    sleep 1
    led.off
    sleep 1
  end
end

# PiPiper.wait
