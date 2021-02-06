
class HandEvaluator
  attr_reader :max_value

  ROYAL_FLUSH_HAS = ['10', 'J', 'Q', 'K', 'A'].sort.freeze
  CARDS_IN_A_HAND = 5.freeze
  HAND_WEIGHT = [
    "Royal Flush": 11,
    "Straight Flush": 10,
    "Poker": 9,
    "Full House": 8,
    "Flush": 7,
    "Straight": 6,
    "Three of a kind": 5,
    "Two pair": 4,
    "Single pair": 3,
    "High card": 2,
    "Unknown hand :(": 1,
  ]

  def initialize(hand)
    @hand = hand
    @identifiers = @hand.cards.collect { |card| card.identifier }
    @figures = @hand.cards.collect { |card| card.figure }
    @values = @hand.cards.collect { |card| card.value }
    @max_value = 0
  end

  def self.calculate_poker_hand(hand)
    @evaluator = HandEvaluator.new(hand)
    return { hand: "Royal Flush", hand_weight: 11, value: @evaluator.max_value } if @evaluator.royal_flush?
    return { hand: "Straight Flush", hand_weight: 10, value: @evaluator.max_value } if @evaluator.straight_flush?
    return { hand: "Poker", hand_weight: 9, value: @evaluator.max_value } if @evaluator.four_of_a_kind?
    return { hand: "Full House", hand_weight: 8, value: @evaluator.max_value } if @evaluator.full_house?
    return { hand: "Flush", hand_weight: 7, value: @evaluator.max_value } if @evaluator.flush?
    return { hand: "Straight", hand_weight: 6, value: @evaluator.max_value } if @evaluator.straight?
    return { hand: "Three of a kind", hand_weight: 5, value: @evaluator.max_value } if @evaluator.three_of_a_kind?
    return { hand: "Two pair", hand_weight: 4, value: @evaluator.max_value } if @evaluator.two_pairs?
    return { hand: "Single pair", hand_weight: 3, value: @evaluator.max_value } if @evaluator.single_pair?
    return { hand: "High card", hand_weight: 2, value: @evaluator.max_value } if @evaluator.high_card?
    return { hand: "Unknown hand :(", hand_weight: 1, value: 0 }
  end

  def self.who_wins(players)
    best_hand = players.collect { |player| player.hand_weight }.max
    best_players = players.select { |player| player.hand_weight == best_hand }

    if best_players.size == 1
      best_player = best_players[0]
      best_player.winner = true
    end

    return best_player unless best_player.nil?

    best_card = best_players.collect { |player| player.resulting_value }.max
    best_player = best_players.select { |player| player.resulting_value == best_card }[0]
    # p best_players.collect { |player| "#{player.name}: #{player.resulting_value}" }
    best_player.winner = true
    best_player
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
    poker = group_and_count(@identifiers, "how_many == 4")
    @max_value = @hand.cards.find { |card| card.identifier == poker.keys[0] }&.value

    !poker.empty?
  end

  def full_house?
    full = group_and_count(@values, "how_many == 3 || how_many == 2")
    @max_value = full.keys.max

    full.length == 2 && (!@max_value.nil? && full.values.max == 3)
  end

  def flush?
    @max_value = @values.max
    @figures.uniq.length == 1
  end

  def three_of_a_kind?
    three = group_and_count(@values, "how_many == 3")
    @max_value = three.keys.max

    three.size == 1
  end

  def two_pairs?
    two = group_and_count(@values, "how_many == 2")
    @max_value = two.keys.max

    two.size == 2
  end

  def single_pair?
    pair = group_and_count(@values, "how_many == 2")
    @max_value = pair.keys[0]

    pair.size == 1
  end

  def high_card?
    @max_value = @values.max
  end

  private
  def group_and_count(array, rule)
    array.group_by(&:itself)
    .transform_values(&:size)
    .select do |identifier, how_many|
      eval(rule)
    end
  end
end
