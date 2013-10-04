require_relative "round"

class Game
  attr_reader :stuff, :rounds

  def initialize(stuff)
    @stuff = stuff
    @rounds = []
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

  def player_turn?
    !!@player_turn
  end

  def next_round
    Round.new(rounds.size + 1, colors).tap do |round|
      rounds << round
    end
  end
end
