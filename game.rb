class Game
  attr_reader :stuff

  def initialize(stuff)
    @stuff = stuff
  end

  def leds
    stuff.map { |_, s| s[:led] }
  end

  def pairs
    stuff.values.map { |s| [s[:led], s[:button]] }
  end

  def colors
    stuff.keys
  end

  def led_for(color)
    stuff[color][:led]
  end
end
