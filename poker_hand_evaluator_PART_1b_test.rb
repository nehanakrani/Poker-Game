require_relative 'poker_hand_evaluator'
require 'minitest'
require 'minitest/autorun'

describe PokerHandEvaluator do
  describe 'validations' do
    it 'raises error when a hand contains two of same card' do
      hands = [
        %w[4D 6S QH QH QC].shuffle.join(' '), # 2 x QH
        %w[3D 6D 7H QD QS].shuffle.join(' ')
      ].shuffle
      expect { PokerHandEvaluator.new(hands) }
        .must_raise PokerHandEvaluator::InvalidHandError
    end

    it 'raises error when different hands contain the same card' do
      hands = [
        %w[4D 6S 6D QH QC].shuffle.join(' '), # 1 x QH
        %w[3D QH 7H QD QS].shuffle.join(' '), # another QH
        %w[3H 9D 0D AH AD].shuffle.join(' ')
      ].shuffle
      expect { PokerHandEvaluator.new(hands) }
        .must_raise PokerHandEvaluator::InvalidHandError
    end

    it 'raises error when hand(s) contain less than 5 cards' do
      hands = [
        %w[4D 6S 5D QC].shuffle.join(' '), # 4 card hand
        %w[3D 6D 7H QD QS].shuffle.join(' ')
      ].shuffle
      expect { PokerHandEvaluator.new(hands) }
        .must_raise PokerHandEvaluator::InvalidHandError
    end

    it 'raises error when hand(s) contain more than 5 cards' do
      hands = [
        %w[4D 6S 6D QS QC KS].shuffle.join(' '), # 6 card hand
        %w[3D QH 7H QD 8S].shuffle.join(' ')
      ].shuffle
      expect { PokerHandEvaluator.new(hands) }
        .must_raise PokerHandEvaluator::InvalidHandError
    end
  end
end
