require_relative "../../players/player"
require_relative "../../cards/deck"
require_relative "../../cards/hand"
require_relative "../../cards/card"

describe Player do
  describe "#see_hand" do
    let(:results) { { hand: "Royal Flush", hand_weight: 11, value: 13 } }
    let(:cards) do
      [
        Card.new("10", "spades", 9),
        Card.new("J", "spades", 10),
        Card.new("Q", "spades", 11),
        Card.new("K", "spades", 12),
        Card.new("A", "spades", 13),
      ]
    end
    let(:hand) { Hand.new(cards) }
    let(:player) { Player.new(hand) }

    it "sets result values" do
      player.see_hand(results)

      expect(player.resulting_hand).to eq("Royal Flush")
      expect(player.resulting_value).to eq(13)
      expect(player.hand_weight).to eq(11)
    end
  end
end