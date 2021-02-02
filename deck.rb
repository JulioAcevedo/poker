class Deck
  IDENTIFIERS_VALUES =
    {
        "A": 14,
        "2": 2 ,
        "3": 3 ,
        "4": 4 ,
        "5": 5 ,
        "6": 6 , 
        "7": 7 , 
        "8": 8 ,
        "9": 9 ,
        "10": 10, 
        "J": 11,
        "Q": 12,
        "K": 13,
    }.freeze
   
  FIGURES = ["spades", "hearts", "diamonds", "clovers"].freeze

  def initialize
    @cards = set_up_cards
    @cards_in_deck = @cards.count
  end

  def show_cards
    @cards.each {|card| p card }
  end

  def get_card
    possible_number = Random.rand(@cards_in_deck) - 1
    if @cards[possible_number][:given] == false
        @cards[possible_number][:given] = true
        return @cards[possible_number]
    else
        return get_card
    end
    return nil
  end

  private 
  def set_up_cards
    cards = []
    FIGURES.each do |figure|
        IDENTIFIERS_VALUES.each do |id, value|
            cards.push({
               identifier: id,
               value: value,
               figure: figure,
               given: false,
           })
        end
    end
    cards
  end
end
