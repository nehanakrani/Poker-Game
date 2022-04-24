
require 'pry'
class PokerHandEvaluator
  require_relative "hand"
  require_relative "card"
  attr_reader :hands

  def initialize(hand_arrays)
    @hands = hand_arrays&.map { |hand_array| Hand.new(hand_array) }
  end

  def hand_classifications
    hands.select{ |hand| hand.score == hands.map(&:score).max }.map(&:hand_array)
  end
end

# Test case example 1:
# high_of_jack = %w[AS KC 3H 8C 5H]
# game = PokerHandEvaluator.new([high_of_jack])
# print game.hand_classifications
# print high_of_jack
