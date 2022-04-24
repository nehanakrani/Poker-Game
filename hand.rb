class PokerHandEvaluator::Hand
  attr_reader :hand_array, :cards

  def initialize(hand_array)
    @hand_array = hand_array
    @cards = hand_array.map { |string| PokerHandEvaluator::Card.new(string) }
  end

  def score
    [hand_score, card_score].flatten
  end

  private

  def hand_score
    scoring_hands.map.with_index { |scoring_hand, i| i if scoring_hand }.compact.max
  end

  def scoring_hands
    [high_card?, one_pair?, two_pair?, three_of_a_kind?, five_high_straight?,
     straight?, flush?, full_house?, four_of_a_kind?, straight_flush?]
  end

  def card_score
    five_high_straight? ? [5, 4, 3, 2, 1] : card_score_list
  end

  def card_score_list
    rank_count_hash
        .sort_by { |rank, count| [-count, -rank] }
        .map { |count_rank_array| count_rank_array[0] }
  end

  # define scoring_hands methods
  def high_card?
    rank_count_totals.max == 1
  end

  def one_pair?
    rank_count_totals.max == 2
  end

  def two_pair?
    rank_count_totals.sort == [1, 2, 2]
  end

  def three_of_a_kind?
    rank_count_totals&.max == 3
  end

  def five_high_straight?
    rank_values&.sort == [2, 3, 4, 5, 14]
  end

  def straight?
    rank_values&.each_cons(2).all? { |a, b| a + 1 == b }
  end

  def flush?
    cards&.map(&:suit)&.uniq&.count == 1
  end

  def full_house?
    rank_count_totals.sort == [2, 3]
  end

  def four_of_a_kind?
    rank_count_totals.max == 4
  end

  def straight_flush?
    straight? && flush?
  end

  def rank_count_totals
    rank_count_hash&.values unless rank_count_hash.nil?
  end

  def rank_count_hash
    rank_values&.each_with_object(Hash.new(0)) { |value, count| count[value] += 1 }
  end

  def rank_values
    cards&.map(&:rank_value).compact&.sort unless cards.nil?
  end

end