Feature: Inference
  Scenario: Starting the program
    Given I have started the program
    Then I should see "Enter a statement:"

  Scenario: User inputs simple syllogism
    Given I input "All cats are mammals"
    And I input "All mammals have fur"
    When I type "Do all cats have fur?"
    Then the output should be "Yes"
