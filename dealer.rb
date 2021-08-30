class Dealer < Player
  def initialize(name)
    @name = name
    @cards = []
  end

  def to_s
    "Dealer #{name}"
  end
end