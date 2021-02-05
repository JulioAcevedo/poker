require_relative "interfaces/user_interface"
require_relative "cards/deck"
require_relative "cards/hand_evaluator"
require_relative "players/player"

class PokerGame
  def initialize(how_many_players)
    raise Exception.new("Number of players allowed: 1 to 10") unless how_many_players
    @deck = Deck.new
    @players = []
    how_many_players.times { @players << Player.new(@deck.hand) }
  end

  def play
    UserInterface.clear_screen
    UserInterface.say_hi
    @players.each do |player|
      player.see_hand(HandEvaluator.calculate_poker_hand(player.hand))
    end
    winner = HandEvaluator.decide_who_wins(@players)
    UserInterface.say_the_winner(winner.name, winner.resulting_hand, winner.hand)
    UserInterface.say_good_bye
  end
end

user_input = ""
until ["no"].include? user_input do
  PokerGame.new(UserInterface.ask_for_players).play
  user_input = UserInterface.play_again?
end
