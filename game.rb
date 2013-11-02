class Game
  attr_reader :pairs, :pattern

  def initialize(pairs)
    @pairs = pairs
    @pattern = []
  end

  def leds
    pairs.map { |p| p[:led] }
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
    leds.each { |l| l.off }
    @current_index = 0
    flashy if @pattern.empty?
    @pattern << pairs.sample
    @waiting = true
  end

  def pair_from_button(button)
    pairs.find { |p| p[:button] == button }
  end

  def pressed(button)
    pair = pair_from_button(button)

    if pattern[@current_index] == pair
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

  def show_pattern
    delay = 0.5
    pattern.each do |pair|
      sleep delay
      pair[:led].on
      sleep delay
      pair[:led].off
    end
  end

  def flashy
    5.times do
      leds.each do |led|
        sleep 0.05
        led.on
        sleep 0.05
        led.off
      end
    end
  end
end
