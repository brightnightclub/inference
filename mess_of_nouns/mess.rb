class Mess
  attr_accessor :input_string, :first_noun, :second_noun

  def initialize(input_string)
    @input_string = input_string
    parse_nouns
    define_classes_from_nouns
  end

  def parse_nouns
    noun_matches = input_string.match(/^all (.+) are (.+)?/i)
    @first_noun = noun_matches[1]
    @second_noun = noun_matches[2]
  end

  def define_classes_from_nouns
    first_class_name = @first_noun.split(' ').map(&:capitalize).join('')
    second_class_name = @second_noun.split(' ').map(&:capitalize).join('')

    first_class = unless class_exists?(first_class_name)
      Object.const_set(first_class_name, Module.new)
    else
      Module.const_get(first_class_name)
    end

    second_class = unless class_exists?(second_class_name)
      Object.const_set(second_class_name, Module.new)
    else
      Module.const_get(second_class_name)
    end

    first_class.send(:include, second_class)
  end

  def class_exists?(class_name)
    klass = Module.const_get(class_name)
    klass.is_a?(Class) || klass.is_a?(Module)
  rescue NameError
    return false
  end
end
