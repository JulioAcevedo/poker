require_relative "card"
require_relative "hand"


class Deck
  ID = 0
  FIGURE = 1
  IDENTIFIERS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].freeze
  FIGURES = ["spades", "hearts", "diamonds", "clovers"].freeze

  def show_cards
    deck.each {|card| p card }
  end

  def hand
    Hand.new(deck.slice!(0, 5))
  end

  private
  def deck
    @deck ||=
      FIGURES.map do |figure|
        IDENTIFIERS.map.with_index(1) do |identifier, index|
          Card.new(identifier[0], figure, index)
        end
      end.flatten.shuffle
  end
end
