require_relative "../../cards/hand_evaluator"
require_relative "../../cards/hand"
require_relative "../../cards/card"

describe HandEvaluator do
  describe "#royal_flush?" do
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
    let(:cards) do
      [
        Card.new("2", "spades", 1),
        Card.new("3", "spades", 2),
        Card.new("4", "spades", 3),
        Card.new("5", "spades", 4),
        Card.new("6", "spades", 5),
      ]
    end
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
    let(:cards) do
      [
        Card.new("A", "spades", 13),
        Card.new("A", "hears", 13),
        Card.new("9", "spades", 8),
        Card.new("A", "diamonds", 13),
        Card.new("A", "clover", 13),
      ]
    end
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
    let(:cards) do
      [
        Card.new("A", "spades", 13),
        Card.new("A", "hears", 13),
        Card.new("9", "spades", 8),
        Card.new("9", "diamonds", 8),
        Card.new("A", "clover", 13),
      ]
    end
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
    let(:cards) do
      [
        Card.new("A", "spades", 13),
        Card.new("4", "spades", 3),
        Card.new("6", "spades", 5),
        Card.new("K", "spades", 12),
        Card.new("J", "spades", 10),
      ]
    end
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
    let(:cards) do
      [
        Card.new("2", "spades", 1),
        Card.new("3", "clover", 2),
        Card.new("4", "spades", 3),
        Card.new("5", "hearts", 4),
        Card.new("6", "spades", 5),
      ]
    end
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
    let(:cards) do
      [
        Card.new("A", "spades", 13),
        Card.new("A", "hears", 13),
        Card.new("9", "spades", 8),
        Card.new("2", "diamonds", 1),
        Card.new("A", "clover", 13),
      ]
    end
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
    let(:cards) do
      [
        Card.new("A", "spades", 13),
        Card.new("A", "hears", 13),
        Card.new("3", "spades", 2),
        Card.new("2", "diamonds", 1),
        Card.new("3", "clover", 2),
      ]
    end
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
    let(:cards) do
      [
        Card.new("A", "spades", 13),
        Card.new("A", "hears", 13),
        Card.new("3", "spades", 2),
        Card.new("2", "diamonds", 1),
        Card.new("4", "clover", 3),
      ]
    end
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
    let(:cards) do
      [
        Card.new("A", "spades", 13),
        Card.new("J", "hears", 10),
        Card.new("3", "spades", 2),
        Card.new("2", "diamonds", 1),
        Card.new("4", "clover", 3),
      ]
    end
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
