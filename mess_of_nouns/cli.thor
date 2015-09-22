require "thor"
require 'pry'
require_relative './mess'

class MessCli < Thor
  desc "make_mess", "it's fun to make a mess!"
  def make_mess
    loop do
      string = ask('Speak to me plz:')
      begin
        if string == 'stop'
          binding.pry
        elsif string =~ /\?/i
          noun_matches = string.match(/^are all (.+) (.+)./i)
          first_noun = noun_matches[1]
          second_noun = noun_matches[2]
          first_class_name = first_noun.split(' ').map(&:capitalize).join('')
          second_class_name = second_noun.split(' ').map(&:capitalize).join('')
          first_class = Module.const_get(first_class_name)
          second_class = Module.const_get(second_class_name)

          if first_class.ancestors.include?(second_class)
            puts "Yes."
          else
            truthy_array = first_class.ancestors.map do |ancestor|
              ancestor.ancestors.include?(second_class)
            end

            if truthy_array.include?(true)
              puts "Yes."
            else
              puts "I don't know."
            end
          end
        else
          Mess.new(string)
        end
      rescue => e
        puts 'You make no sense.'

        # raise e
      end
    end
  end
end
