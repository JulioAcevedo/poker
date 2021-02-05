
class Player
  FAKE_NAMES = [
    "Alfred",
    "Jorge",
    "Geras",
    "Erick",
    "Majo",
    "Julio",
    "Verónica",
    "Armando",
    "LaBikla",
    "Cualquiera",
    "Peluchosa",
  ].freeze

  attr_reader :hand, :name, :resulting_hand, :resulting_value, :hand_weight, :winner
  attr_writer :winner

  def initialize(hand)
    @hand = hand
    @name = FAKE_NAMES[Random.rand(10) - 1]
    @winner = false
  end

  def see_hand(results)
    @resulting_hand = results[:hand]
    @hand_weight = results[:hand_weight]
    @resulting_value = results[:value]
  end

  def to_s
    p "#{@name} has this cards:"
    @hand.to_s
  end
end
