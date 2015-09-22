require 'pry'

class Node
  @node_list = Hash.new do |hash, key|
    hash[key] = self.new(key)
  end

  class << self
    attr_accessor :node_list

    def find_or_create(name)
      @node_list[name]
    end
  end

  attr_accessor :name
	def initialize(name)
		@name = name
		@relations = {
			:all	 => [],
			:no		 => [],
			:some	 => [],
    }
	end

  def [](attr)
   @relations[attr]
  end

  def set_relation(other_node, relation_type)
    @relations[relation_type] << other_node
  end

  def has_relation?(relation_type, node)
    if self[relation_type].include? node
      true
    else
      self[relation_type].any? do |obj|
        obj.has_relation?(relation_type, node)
      end
    end
  end

end

class Engine
  def initialize
  end

  def input(statement)
    statement = statement.downcase
    if statement =~ /^are/
      ask(statement)
    else
      say(statement)
    end
  end

  private

  def say(statement)
    statement =~ /^(\w+) ([\w\s]+) are ([\w\s]+)/
    relation_type = $1
    node1 = Node.find_or_create($2)
    node2 = Node.find_or_create($3)

    node1.set_relation(node2, relation_type.to_sym)
  end

  def ask(statement)
    statement =~ /^are (\w+) ([\w\s]+s) ([\w\s]+s)/
    relation_type = $1.to_sym
    node1 = Node.find_or_create($2)
    node2 = Node.find_or_create($3)

    result = node1.has_relation?(relation_type, node2)

    puts "Answer is: #{result}"
    result
  end
end


# Test Runner (the simple kind!)
################################

puts "TestRunner starting"
mammals = Node.new("mammals")
puts "Passed test 1"

hairy_animal = Node.new("hairy animal")
puts "Passed test 2"

mammals.set_relation(hairy_animal, :all)
puts "Passed test 3"


engine = Engine.new()
engine.input("All mammals are hairy animals")

#two nodes should exist here with one relation between them.

engine.input("All dogs are mammals")
engine.input("All beagles are dogs")
engine.input("All beagles are dogs")

if engine.input("Are all beagles dogs?") == true
  puts "Tests green"
end

if engine.input("Are all beagles hairy animals?") == true
  puts "Tests green"
else
  puts "FAILURE!!!!"
end
