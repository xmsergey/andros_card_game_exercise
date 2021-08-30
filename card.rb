class Card
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    case rank
    when 'jack'
      11
    when 'queen'
      12
    when 'king'
      13
    when 'ace'
      14
    else
      rank
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end

  private

  attr_reader :rank, :suit
end