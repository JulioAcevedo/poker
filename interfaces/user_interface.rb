class UserInterface
    def self.say_hi
    puts '--------------------------------------------------------------'
    puts '--------------      Welcome to a Poker Game     --------------'
    puts '--------------------------------------------------------------'
  end

  def self.say_good_bye
    puts '--------------------------------------------------------------'
    puts '--------------         See you nex time         --------------'
    puts '--------------------------------------------------------------'
  end

  def self.say_wrong_values
    puts '--------------------------------------------------------------'
    puts '--------------   There where some wrong values  --------------'
    puts '--------------------------------------------------------------'
    puts " So we could not initialize objects.\n Please correct them and try again."
  end

  def self.ask_for_players
    puts "\nHow many players are gonna loose some money?"
    if (number = gets.chomp.to_i).zero? or number < 1 or number > 10
      say_wrong_values
      return nil
    end
    number
  end

  def self.say_the_winner(name, hand)
    puts "#{name} is the winner having..."
    hand.to_s
  end

  def self.play_again?
    puts '--------------------------------------------------------------'
    puts '--------------        Game finished!!!!         --------------'
    puts '--------------------------------------------------------------'
    puts 'Do you want to play again? (yes / no)'
    gets.chomp.downcase
  end

  def self.clear_screen
    system('clear')
  end
end