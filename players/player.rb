
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
  ].freeze

  attr_reader :hand, :name, :resulting_hand

  def initialize(hand)
    @hand = hand
    @name = FAKE_NAMES[Random.rand(10) - 1]
  end

  def see_hand(results)
    @resulting_hand = results[:hand]
    @resulting_value = results[:value]
  end

  def to_s
    p "#{@name} has this cards:"
    @hand.each { |card| card.to_s }
  end
end
