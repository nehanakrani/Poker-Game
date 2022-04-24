class PokerHandEvaluator::Card
  RANK_VALUES = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                 '7' => 7, '8' => 8, '9' => 9, '10' => 10,
                 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}

  attr_reader :rank, :suit

  def initialize(rank_and_suit)
    @rank = rank_and_suit[0..-2]
    @suit = rank_and_suit[-1]
  end

  def rank_value
    RANK_VALUES[rank]
  end
end