class Card
  attr_reader :identifier, :figure, :value

  def initialize(id, figure, value)
    @identifier = id
    @figure = figure
    @value = value
  end

  def to_s
    puts "... a #{@identifier} of #{figure} with value #{value}"
  end
end