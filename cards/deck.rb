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
    # Hand.new(deck.slice!(0, 5))
    #### ROYAL FLUSH
    # Hand.new([
    #   Card.new("J", "spades", 10),
    #   Card.new("K", "spades", 12),
    #   Card.new("10", "spades", 9),
    #   Card.new("A", "spades", 13),
    #   Card.new("Q", "spades", 11),
    # ])
    #### NOT ROYAL FLUSH
    # Hand.new([
    #   Card.new("2", "spades", 10),
    #   Card.new("K", "spades", 12),
    #   Card.new("10", "hearts", 9),
    #   Card.new("A", "spades", 13),
    #   Card.new("Q", "spades", 11),
    # ])
    ### STRAIGHT FLUSH
    # Hand.new([
    #   Card.new("2", "spades", 1),
    #   Card.new("3", "spades", 2),
    #   Card.new("4", "spades", 3),
    #   Card.new("5", "spades", 4),
    #   Card.new("6", "spades", 5),
    # ])
    #### Straight
    # Hand.new([
    #   Card.new("2", "spades", 1),
    #   Card.new("3", "clover", 2),
    #   Card.new("4", "spades", 3),
    #   Card.new("5", "hearts", 4),
    #   Card.new("6", "spades", 5),
    # ])
    #### POKER
    # Hand.new([
    #   Card.new("A", "spades", 13),
    #   Card.new("A", "hears", 13),
    #   Card.new("9", "spades", 8),
    #   Card.new("A", "diamonds", 13),
    #   Card.new("A", "clover", 13),
    # ])
    #### NO POKER
    # Hand.new([
    #   Card.new("A", "spades", 13),
    #   Card.new("A", "hears", 13),
    #   Card.new("9", "spades", 8),
    #   Card.new("2", "diamonds", 1),
    #   Card.new("A", "clover", 13),
    # ])
    #### FULL
    # Hand.new([
    #   Card.new("A", "spades", 13),
    #   Card.new("A", "hears", 13),
    #   Card.new("9", "spades", 8),
    #   Card.new("9", "diamonds", 8),
    #   Card.new("A", "clover", 13),
    # ])
    #### FLUSH
    # Hand.new([
    #   Card.new("A", "spades", 13),
    #   Card.new("4", "spades", 3),
    #   Card.new("6", "spades", 5),
    #   Card.new("K", "spades", 12),
    #   Card.new("J", "spades", 10),
    # ])
    #### THREE
    # Hand.new([
    #   Card.new("A", "spades", 13),
    #   Card.new("A", "hears", 13),
    #   Card.new("9", "spades", 8),
    #   Card.new("2", "diamonds", 1),
    #   Card.new("A", "clover", 13),
    # ])
    #### TWO PAIR
    Hand.new([
      Card.new("A", "spades", 13),
      Card.new("A", "hears", 13),
      Card.new("3", "spades", 2),
      Card.new("2", "diamonds", 1),
      Card.new("3", "clover", 2),
    ])
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
