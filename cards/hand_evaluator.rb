
class HandEvaluator
  attr_reader :max_value

  ROYAL_FLUSH_HAS = ['10', 'J', 'Q', 'K', 'A'].sort.freeze
  CARDS_IN_A_HAND = 5.freeze

  def initialize(hand)
    @hand = hand
    @identifiers = @hand.cards.collect { |card| card.identifier }
    @figures = @hand.cards.collect { |card| card.figure }
    @values = @hand.cards.collect { |card| card.value }
    @max_value = 0
  end

  def self.calculate_poker_hand(hand)
    @evaluator = HandEvaluator.new(hand)
    return { hand: "Royal Flush", value: @evaluator.max_value } if @evaluator.royal_flush?
    return { hand: "Straight Flush", value: @evaluator.max_value } if @evaluator.straight_flush?
    return { hand: "Poker", value: @evaluator.max_value } if @evaluator.four_of_a_kind?
    return { hand: "Full House", value: @evaluator.max_value } if @evaluator.full_house?
    return { hand: "Flush", value: @evaluator.max_value } if @evaluator.flush?
    return { hand: "Streight", value: @evaluator.max_value } if @evaluator.straight?
    return { hand: "Three of a kind", value: @evaluator.max_value } if @evaluator.three_of_a_kind?
    return { hand: "Two pair", value: @evaluator.max_value } if @evaluator.two_pairs?
    return { hand: "Single pair", value: @evaluator.max_value } if @evaluator.single_pair?
    return { hand: "High card", value: @evaluator.max_value } if @evaluator.high_card?
    return { hand: "Unknown hand :(", value: 0 }
  end

  def self.decide_who_wins(players)
    players[0]
  end

  def royal_flush?
    @max_value = @values.max
    @identifiers.sort == ROYAL_FLUSH_HAS && @figures.uniq.length == 1
  end

  def straight_flush?
    return false unless straight?
    @figures.uniq.length == 1
  end

  def straight?
    min, max = @values.minmax

    return nil unless max - min == CARDS_IN_A_HAND - 1
    @max_value = max

    @values.uniq.count == 5
  end

  def four_of_a_kind?
    poker = group_and_count("how_many == 4")
    @max_value = @hand.cards.find { |card| card.identifier == poker.keys[0] }&.value

    !poker.empty?
  end

  def full_house?
    full = group_and_count("how_many == 3 || how_many == 2")
    @max_value = @hand.cards.find do |card|
      card.identifier == full&.find { |group| group[1] == 3 }&[0]
    end&.value

    full.length == 2 && !@max_value.nil?
  end

  def flush?
    @max_value = @values.max
    @figures.uniq.length == 1
  end

  def three_of_a_kind?
    three = group_and_count("how_many == 3")
    @max_value = @hand.cards.find do |card|
      card.identifier == three&.find { |group| group[1] == 3 }&[0]
    end&.value

    three.size == 1
  end

  def two_pairs?
    two = group_and_count("how_many == 2")
    @max_value = @hand.cards.find do |card|
      card.identifier == two&.find { |group| group[1] == 2 }&[0]   ## Esto no está bien, hay que buscar el que tenga el value más alto
    end&.value

    two.size == 2
  end

  def group_and_count(rule)
    @identifiers.group_by(&:itself)
    .transform_values(&:size)
    .select do |identifier, how_many|
      eval(rule)
    end
  end
end
