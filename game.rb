class Game
  attr_reader :stuff, :pattern

  def initialize(stuff)
    @stuff = stuff
    @pattern = []
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

  def start
  end

  def waiting?
    !!@waiting
  end

  def player_turn
    @player_turn = true
    while waiting?
      sleep 1
    end
    @player_turn = false
  end

  def player_turn?
    !!@player_turn
  end

  def next_round
    @current_index = 0
    @pattern << colors.sample
    @waiting = true
  end

  def pressed(button)
    color = color_from_button(button)

    if pattern[@current_index] == color
      if @current_index + 1 == pattern.size
        puts "winner!"
        @waiting = false
      else
        @current_index += 1
      end
    else
      puts "fail"
      @pattern = []
      @waiting = false
    end
  end

  def color_from_button(button)
    stuff.keys.find { |k| stuff[k][:button] == button }
  end

  def show_pattern
    delay = 0.5
    pattern.each do |color|
      led = led_for(color)
      led.on
      sleep delay
      led.off
      sleep delay
    end
  end
end
