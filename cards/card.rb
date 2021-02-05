class Card
  attr_reader :identifier, :figure, :value

  def initialize(id, figure, value)
    @identifier = id
    @figure = figure
    @value = value
  end

  def to_s
    # puts "... #{@identifier} of #{figure} with value #{value}"
    puts "... #{@identifier} of #{figure}"
  end
end
