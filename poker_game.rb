require_relative "deck"
require_relative "player"

def say_hi
    puts '--------------------------------------------------------------'
    puts '--------------      Welcome to a Poker Game     --------------'
    puts '--------------------------------------------------------------'
end

def say_good_bye
    puts '--------------------------------------------------------------'
    puts '--------------         See you nex time         --------------'
    puts '--------------------------------------------------------------'
end

def say_wrong_values
    puts '--------------------------------------------------------------'
    puts '--------------   There where some wrong values  --------------'
    puts '--------------------------------------------------------------'
    puts " So we could not initialize objects.\n Please correct them and try again."
end
  
def ask_for_players
    puts "\nHow many players are gonna loose some money?"
    if (number = gets.chomp.to_i).zero?
        say_wrong_values
        return nil 
    end

    number
end

system('clear')

@deck = Deck.new
say_hi
@how_many_players = ask_for_players
return nil unless @how_many_players or @how_many_players > 10
@players = []
@how_many_players.times do 
    @players.push(Player.new(@deck))
end
@players.each { |player| p player.show_hand }
say_good_bye