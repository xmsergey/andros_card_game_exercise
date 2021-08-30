class Deck
  def initialize
    @cards = RANKS.product(SUITES).map { Card.new(*_1) }
  end

  def shuffle!
    cards.shuffle!
  end

  def deal_card
    cards.shift
  end

  def return_cards(returned_cards)
    cards.push(*returned_cards)
  end

  private

  attr_accessor :cards

  RANKS = [*(2..10), 'jack', 'queen', 'king', 'ace']
  SUITES = %w[clubs diamonds hearts spades]
end