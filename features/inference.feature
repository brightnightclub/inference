Feature: Inference
  Scenario: Starting the program
    Given I have started the program
    Then I should see "Enter a statement:"

  Scenario: User inputs simple syllogism
    Given I input "All cats are mammals"
    And I input "All mammals are furry"
    When I type "Are all cats furry?"
    Then the output should be "Yes"
