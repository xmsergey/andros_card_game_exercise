class Hand
  include Comparable

  def initialize(card1, card2)
    @card1 = card1
    @card2 = card2
  end

  def value
    card1.value + card2.value
  end

  def <=> (other)
    value <=> other.value
  end

  private

  attr_accessor :card1, :card2
end