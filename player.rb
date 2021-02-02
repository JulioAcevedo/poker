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

class Player
    def initialize(cards)
        @hand = []
        5.times do
            @hand.push(cards.get_card)
        end
        @name = FAKE_NAMES[Random.rand(10) - 1]
    end

    def show_hand
        p "#{@name} has this cards:"
        @hand.each do |card|
            p card
        end
    end
end