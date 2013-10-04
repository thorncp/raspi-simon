require "pi_piper"

class Button
  attr_reader :pin_number

  def initialize(pin_number)
    @pin_number = pin_number
  end

  def pushed(&block)
    PiPiper.after pin: pin_number, goes: :low do
      block.call(self)
    end
  end

  def released(&block)
    PiPiper.after pin: pin_number, goes: :high do
      block.call(self)
    end
  end
end
