require "pi_piper"

class Led < PiPiper::Pin
  def initialize(pin_number)
    super(pin: pin_number, direction: :out)
  end

  def toggle
    read
    on? ? off : on
  end
end
