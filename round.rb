class Round
  attr_reader :pattern

  def initialize(size, colors)
    @pattern = size.times.map { colors.sample }
  end
end
