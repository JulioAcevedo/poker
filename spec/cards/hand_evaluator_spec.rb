require_relative "../../cards/hand_evaluator"
require_relative "../../cards/hand"
require_relative "../../cards/card"
require_relative "../../players/player.rb"
require_relative "../resulting_hands/resulting_hands.rb"

describe HandEvaluator do
  describe "#who_wins" do
    context "5 players with different resulting hands" do
      let(:winner) { Player.new(Hand.new(RESULTING_HANDS[:royal_flush])) }
      let(:players) do
        [
          Player.new(Hand.new(RESULTING_HANDS[:pair])),
          Player.new(Hand.new(RESULTING_HANDS[:two_pairs])),
          Player.new(Hand.new(RESULTING_HANDS[:high_card_ace])),
          winner,
          Player.new(Hand.new(RESULTING_HANDS[:straight])),
        ]
      end

      it "wins the one with RoyalFlush hand" do
        players.each do |player|
          player.see_hand(HandEvaluator.calculate_poker_hand(player.hand))
        end

        expect(HandEvaluator.who_wins(players)).to eq(winner)
      end
    end

    context "5 players with same hand, but different highest card" do
      let(:winner) { Player.new(Hand.new(RESULTING_HANDS[:three_of_aces])) }
      let(:players) do
        [
          Player.new(Hand.new(RESULTING_HANDS[:pair])),
          Player.new(Hand.new(RESULTING_HANDS[:three_of_nines])),
          winner,
          Player.new(Hand.new(RESULTING_HANDS[:high_card_ace])),
          Player.new(Hand.new(RESULTING_HANDS[:two_pairs])),
        ]
      end

      it "wins the one with Three of the Same hand with aces" do
        players.each do |player|
          player.see_hand(HandEvaluator.calculate_poker_hand(player.hand))
        end

        expect(HandEvaluator.who_wins(players)).to eq(winner)
      end
    end

    context "5 players in groups of players with same hand, but different highest card" do
      let(:winner) { Player.new(Hand.new(RESULTING_HANDS[:three_of_aces])) }
      let(:players) do
        [
          Player.new(Hand.new(RESULTING_HANDS[:high_card_ace])),
          Player.new(Hand.new(RESULTING_HANDS[:three_of_nines])),
          winner,
          Player.new(Hand.new(RESULTING_HANDS[:high_card_J])),
          Player.new(Hand.new(RESULTING_HANDS[:two_pairs])),
        ]
      end

      it "wins the one with Three of the Same hand with aces" do
        players.each do |player|
          player.see_hand(HandEvaluator.calculate_poker_hand(player.hand))
        end

        expect(HandEvaluator.who_wins(players)).to eq(winner)
      end
    end
  end

  describe "#royal_flush?" do
    let(:cards) { RESULTING_HANDS[:royal_flush] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is a Royal Flush" do
      expect(hand_evaluator.royal_flush?).to be_truthy
    end

    let(:expected_result) { { hand: "Royal Flush", hand_weight: 11, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#straight_flush?" do
    let(:cards) { RESULTING_HANDS[:straight_flush] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is a Straight Flush" do
      expect(hand_evaluator.straight_flush?).to be_truthy
    end

    let(:expected_result) { { hand: "Straight Flush", hand_weight: 10, value: 5 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#four_of_a_kind?" do
    let(:cards) { RESULTING_HANDS[:poker] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is Poker" do
      expect(hand_evaluator.four_of_a_kind?).to be_truthy
    end

    let(:expected_result) { { hand: "Poker", hand_weight: 9, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#full_house?" do
    let(:cards) { RESULTING_HANDS[:full_house] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is Full House" do
      expect(hand_evaluator.full_house?).to be_truthy
    end

    let(:expected_result) { { hand: "Full House", hand_weight: 8, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#flush?" do
    let(:cards) { RESULTING_HANDS[:flush] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is Flush" do
      expect(hand_evaluator.flush?).to be_truthy
    end

    let(:expected_result) { { hand: "Flush", hand_weight: 7, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#straight?" do
    let(:cards) { RESULTING_HANDS[:straight] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is Straight" do
      expect(hand_evaluator.straight?).to be_truthy
    end

    let(:expected_result) { { hand: "Straight", hand_weight: 6, value: 5 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#three_of_a_kind?" do
    let(:cards) { RESULTING_HANDS[:three_of_aces] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is Three Of A Kind" do
      expect(hand_evaluator.three_of_a_kind?).to be_truthy
    end

    let(:expected_result) { { hand: "Three of a kind", hand_weight: 5, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#two_pairs?" do
    let(:cards) { RESULTING_HANDS[:two_pairs] }
    let(:two_pair_hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(two_pair_hand) }

    it "evaluate if hand is Two Pairs" do
      expect(hand_evaluator.two_pairs?).to be_truthy
    end

    let(:expected_result) { { hand: "Two pair", hand_weight: 4, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(two_pair_hand) }

    it "results in a Two Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#single_pair?" do
    let(:cards) { RESULTING_HANDS[:pair] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is single Pair" do
      expect(hand_evaluator.single_pair?).to be_truthy
    end

    let(:expected_result) { { hand: "Single pair", hand_weight: 3, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a Single Pair hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end

  describe "#high_card?" do
    let(:cards) { RESULTING_HANDS[:high_card_ace] }
    let(:hand) { Hand.new(cards) }
    let(:hand_evaluator) { HandEvaluator.new(hand) }

    it "evaluate if hand is High Card" do
      expect(hand_evaluator.high_card?).to be_truthy
    end

    let(:expected_result) { { hand: "High card", hand_weight: 2, value: 13 } }
    let(:obtained_result) { HandEvaluator.calculate_poker_hand(hand) }

    it "results in a High Card hand" do
      expect(obtained_result).to eq(expected_result)
    end
  end
end
