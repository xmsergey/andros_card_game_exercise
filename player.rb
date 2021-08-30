class Player
  def initialize(name)
    # Emulate remote Player
    sleep rand(0..0.2)

    @name = name
    @cards = []
  end

  def get_cards(card1, card2)
    puts "#{self} cards: #{card1}, #{card2}"
    cards.push(card1)
    cards.push(card2)
  end

  def return_cards
    cards.shift(2)
  end

  def hand
    Hand.new(*cards)
  end

  def to_s
    "Player #{name}"
  end

  private

  attr_reader :cards, :name
end