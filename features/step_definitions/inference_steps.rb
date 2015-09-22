Given(/^I have started the program$/) do
  program = InferenceCLI.new
end

Then(/^I should see "([^"]*)"$/) do |output|
  pending
end

Given(/^I input "([^"]*)"$/) do |sentence|
  @cli ||= InferenceCLI.new
  @cli.take_input sentence
end

When(/^I type "([^"]*)"$/) do |input|
  step 'I input "' + input + '"'
end

Then(/^the output should be "(.*)"$/) do |output|
  pending
end
