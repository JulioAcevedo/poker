class Hand
  attr_reader :cards

  def initialize(cards_array)
    @cards = cards_array
  end

  def to_s
    puts '...hand:'
    @cards.each { |card| card.to_s }
  end
end
