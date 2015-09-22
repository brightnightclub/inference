require 'spec_helper'

describe Syllogism do
  describe 'initialize' do
    it 'sets the antecedents' do
      syllogism = Syllogism.new('All cats are mammals', 'All mammals are furry')
      expect(syllogism.antecedents).to eql ['All cats are mammals', 'All mammals are furry']
    end

    it 'calls establish_truth_values' do
      expect_any_instance_of(Syllogism).to receive(:establish_truth_values)
      syllogism = Syllogism.new('All cats are mammals', 'All mammals are furry')
    end
  end
end
