@canary
Ability: Gate Content Based on Permissions

  Scenario: Test users cannot view admin-only content
    * overlord cannot be viewed by a tester user

  Scenario: Admin users can view admin-only content
    * overlord can be viewed by an admin user
