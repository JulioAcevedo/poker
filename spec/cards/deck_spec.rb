require_relative "../../cards/deck"

describe Deck do
  describe "#hand" do
    let(:deck) { Deck.new }
    let(:hand) { deck.hand }

    it "gets 5 random cards objects from deck" do
      expect(hand.cards.count).to eq(5)
    end
  end
end
