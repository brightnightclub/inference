require 'spec_helper'

describe Inference do
  describe 'initialize' do
    it 'creates statements array' do
      inference = Inference.new
      expect(inference.statements).to eql []
    end  
  end
end
