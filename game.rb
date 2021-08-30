require 'timeout'

class Game
  NAMES = %w[Elon Jeff Bill Richard Anne Joe Tiffany Andrew Todd Jordan Rachel Jim]

  def initialize
    @players = Queue.new
    @dealer = Dealer.new(NAMES.sample)
    @deck = Deck.new
  end

  def start
    connect_all_remote_players
    game_loop { next_round }
  end

  def next_round
    deck.shuffle!
    deal_cards
    reveal_winner
    return_cards_to_deck
  end

  private

  def game_loop
    input = 'y'
    while %w[Y y].include?(input) do
      yield
      puts "Do you want to play another round? [y/n]:"
      input = gets.chomp
    end
  end

  def connect_all_remote_players
    threads = []
    (1..6).each do |player_number|
      threads << Thread.new do
        connect_new_player(player_number, 0.1, 3)
      end
    end

    threads.each(&:join)
  end

  def connect_new_player(player_number, timeout, retries)
    attempt ||= 1
    player_name = "#{player_number} #{NAMES.sample}"

    begin
      player = Timeout::timeout(timeout) do
        Player.new(player_name)
      end
      players.push(player)
    rescue Timeout::Error => e
      $stderr.puts "Timeout exception for player #{player_name}. Attempt to connect #{attempt} of #{retries}"
      retry if (attempt += 1) <= retries
      $stderr.puts "Timeout exception for player #{player_name}. Player wasn't connected to the game"
    end
  end

  def players_scope
    players.size.times do
      player = players.pop
      yield player
      players.push(player)
    end
  end

  def deal_cards
    players_scope { _1.get_cards(deck.deal_card, deck.deal_card) }
    dealer.get_cards(deck.deal_card, deck.deal_card)
  end

  def reveal_winner
    winner = dealer
    players_scope { winner = _1 if winner.hand < _1.hand }
    puts "Winner #{winner}"
  end

  def return_cards_to_deck
    players_scope { deck.return_cards(_1.return_cards) }
    deck.return_cards(dealer.return_cards)
  end

  attr_accessor :dealer, :players, :deck, :queue
end