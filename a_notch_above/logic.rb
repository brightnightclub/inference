require 'pry'

class Logic
  def initialize
    @relatables = []
  end

  def process(input)
    relatable = create_relatable(input)
    @relatables = relatable.process
  end

  private
  def question?(input)
    input =~ /\?$/
  end

  def create_relatable(input)
    if question?(input)
      Question.new(@relatables, input)
    else
      Statement.new(@relatables, input)
    end
  end

end

class Question

  def initialize(relatables, input)
    @relatables = relatables
    @input = input
  end

  def process
    set, instance = @input.split("is a").map{|noun| noun.strip}
    if get_relatable(set).contains?(get_relatable(instance))
      return "Yes"
    else
      return "I have no idea"
    end
  end

  def get_relatable(noun)
    relatable = @relatables.detect {|relatable| relatable.noun == noun}
    if !relatable
      relatable = Relatable.new(noun)
    end
    relatable
  end

end


class AreString
  def self.is_handleable?(statement)
    statement =~ /are/i
  end

  #returns array [set, instance]
  def self.handle(statement)
    statement.split("are").map{|noun| noun.gsub(/^All/, "").strip}
  end
end

class DoString
  def self.is_handleable?(statement)
    false
  end

  def self.handle(statement)
  end
end

class Statement

  attr_accessor :relatables

  @@string_handlers = [AreString, DoString]

  def initialize(relatables, input)
    @relatables = relatables
    @input = input
  end

  def process
    @input.downcase!
    handler = @@string_handlers.detect do |string_handler|
      string_handler.is_handleable?(@input)
    end
    nouns = handler.handle(@input)
    nouns = nouns.map{|noun| get_relatable noun}
    nouns.first.add_related(nouns.last)
    @relatables << nouns
    @relatables.flatten
  end

  def get_relatable(noun)
    relatable = @relatables.detect {|relatable| relatable.noun == noun}
    if !relatable
      relatable = Relatable.new(noun)
    end
    relatable
  end
end

class Relatable
  attr_accessor :noun

  def initialize(noun)
    @related = []
    @noun =noun
  end

  def add_related(related)
    @related << related
  end

  def contains?(noun)
    if @noun == noun
      true
    else
      @related.map{|rel| rel.noun == noun}.detect(true)
    end
  end
end





logic_engine = Logic.new

["All dogs are mammals",
  "All mammals are furry",
  "Are dogs furry?"].each do |statement|
    puts logic_engine.process(statement)
  end
