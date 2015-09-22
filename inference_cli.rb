require_relative './inference'

class InferenceCLI
  attr_reader :inference

  def initialize
    @inference = Inference.new
    STDOUT.puts 'Enter a statement:'
  end

  def take_input string
    @inference.statements << string unless string.match(/\?$/)
  end
end
