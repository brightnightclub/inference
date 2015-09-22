class Syllogism
  attr_accessor :antecedents

  def initialize premise1, premise2
    @antecedents = [premise1, premise2]
    establish_truth_values
  end

  def establish_truth_values
    @truth_values = []

    @antecedents.each do |premise|
      subject = premise.match(/(?:(All|No) )(.*)(?: are)/)
      precedent = premise.match(/(?:are )(.*)$/)
      @truth_values.push([subject, precedent, true])
    end
  end
end
