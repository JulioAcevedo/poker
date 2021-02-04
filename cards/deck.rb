require_relative "card"
require_relative "hand"

ID = 0
FIGURE = 1
IDENTIFIERS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].freeze
FIGURES = ["spades", "hearts", "diamonds", "clovers"].freeze

class Deck
  def show_cards
    deck.each {|card| p card }
  end

  def get_hand
    Hand.new(deck.slice!(0, 5))
  end

  private
  def deck
    # @deck ||=
    #   IDENTIFIERS.product(FIGURES).map.with_index(1) do |product, index|
    #     Card.new(product[ID], product[FIGURE], index)
    #   end.shuffle
    @deck ||=
      FIGURES.map do |figure|
        IDENTIFIERS.map.with_index(1) do |identifier, index|
          Card.new(identifier[0], figure, index)
        end
      end.flatten.shuffle
  end
end
