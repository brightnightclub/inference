require 'spec_helper'

describe InferenceCLI do
  describe 'initialize' do
    it 'instantiates an Inference instance' do
      expect(Inference).to receive(:new)
      cli = InferenceCLI.new
    end

    it 'prompts the user' do
      expect(STDOUT).to receive(:puts).with('Enter a statement:')
      cli = InferenceCLI.new
    end
  end

  describe 'take_input' do
    context 'statement' do
      it 'passes statements to the Inference' do
        cli = InferenceCLI.new
        cli.take_input 'All mammals are furry'
        expect(cli.inference.statements).to eql ['All mammals are furry']
      end
    end

    context 'question' do
      it 'doesn\'t pass the question to then statements array' do
        cli = InferenceCLI.new
        cli.take_input 'Are all mammals furry?'
        expect(cli.inference.statements).not_to include 'Are all mammals furry?'
      end
    end
  end
end
