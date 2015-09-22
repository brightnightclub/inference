
require_relative "cli"
require "minitest/autorun"

class TestCLI < Minitest::Test
	def setup
		@cli = CLI.new
	end

	def test_input_new_fact
		response = @cli.tell("All mammals are hairy animals.")
		assert_equal "OK", response
	end


	def x_input_known_fact
		@cli.tell("All cats are hairy animals.")
		response = @cli.tell("All cats are hairy animals.")
		assert_equal "I know.", response
	end

	def test_parse_facts
		response = @cli.parse("All mammals are hairy animals.")
		assert_equal ["fact", "all?", "mammals", "hairy animals"], response

		response = @cli.parse("No cats are dogs.")
		assert_equal ["fact", "!any?", "cats", "dogs"], response

		response = @cli.parse("Some mammals are brown animals.")
		assert_equal ["fact", "any?", "mammals", "brown animals"], response

		response = @cli.parse("Some mammals are not brown animals.")
		assert_equal ["fact", "!all?", "mammals", "brown animals"], response
	end

	def test_parse_query
		response = @cli.parse("Are all foo bar?")
		assert_equal ["query", "all?", "foo", "bar"], response

		response = @cli.parse("Are no foo bar?")
		assert_equal ["query", "!any?", "foo", "bar"], response

		response = @cli.parse("Are any foo bar?")
		assert_equal ["query", "any?", "foo", "bar"], response

		response = @cli.parse("Are any foo not bar?")
		assert_equal ["query", "!all?", "foo", "bar"], response
	end

end
