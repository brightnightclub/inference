

class CLI
  def graph
    @graph ||= Hash.new(){ |h, k| h[k] = [] }
  end

  def input(statement)
    type, quantifier, subject, object = parse(statement.downcase)
    if type == "fact"
      case quantifier
      when "all?"
        graph[subject] << ["all?", object]
        graph[object] << ["any?", subject]
      end
    elsif type == "query"
      case quantifier
      when "any?"
        graph[subject].any? do |q, n|
          (q == "any?" || q == "all?") && n == object
        end
      end

    end
  end

  def tell(fact)
    "OK"
  end

  def parse(statement)
    case statement
    when /All ([\s\w]+) are ([\s\w]+)\./i
      ["fact", "all?", $1, $2]
    when /No ([\s\w]+) are ([\s\w]+)\./i
      ["fact", "!any?", $1, $2]
    when /Some ([\s\w]+) are not ([\s\w]+)\./i
      ["fact", "!all?", $1, $2]
    when /Some ([\s\w]+) are ([\s\w]+)\./i
      ["fact", "any?", $1, $2]
    when /Are all ([\s\w]+) ([\s\w]+)?/i
      ["query", "all?", $1, $2]
    when /Are no ([\s\w]+) ([\s\w]+)?/i
      ["query", "!any?", $1, $2]
    when /Are any ([\s\w]+) not ([\s\w]+)?/i
      ["query", "!all?", $1, $2]
    when /Are any ([\s\w]+) ([\s\w]+)?/i
      ["query", "any?", $1, $2]
    else
      raise(NotImplementedError)
    end
  end
end


if $0 == __FILE__
  new_cli = CLI.new
  while true
    user_input = gets.chomp
    break if user_input.empty?
    puts new_cli.input(user_input)
  end
end
