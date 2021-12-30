Feature: Sign in

@SEVERITY:CRITICAL
Scenario: Sign in successfully
  Given "Bob" has an account
  When "Bob" signs in
  Then "Bob" should be able to access the account information successfully