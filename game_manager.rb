require_relative './game.rb'
require_relative './player.rb'
require_relative './dealer.rb'
require_relative './hand.rb'
require_relative './card.rb'
require_relative './deck.rb'

class GameManager
  class << self
    def start
      puts "Card Game Exercise"

      input = ''
      while input != '3' do
        puts "Enter '1' to start new game, '2' to print the rules, '3' to exit:"
        input = gets.chomp

        next(puts "Incorrect input. Select any value from: '1' or '2' or '3'") unless %w[1 2 3].include?(input)
        next(puts rules) if input == '2'
        Game.new.start if input == '1'
      end

      puts "End of Game."
    end

    def rules
%{Rules:
- There is 1 dealer
- There are 5 players
- There is 1 standard 52 card deck (no jokers)
- Deal 2 cards per player in a round robin manner
- Between hands, all cards return to the deck, which must be then shuffled
- It is players vs dealer
- The highest hand wins
- The winner is announced at the end of each hand }
    end
  end
end

GameManager.start