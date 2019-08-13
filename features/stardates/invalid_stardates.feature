Feature: Gracefully Handle Invalid Stardates

  Background:
    Given an authenticated user on the stardate page

  Scenario: Stardate Cannot Be Blank
    * a blank stardate returns a warning message:
      """
      Please supply a stardate or there is no point.
      """

  Scenario: Stardate Must Be Numeric
    * a stardate with only letters returns a warning message:
      """
      Stardates have to be a number.
      """

    * a stardate with some letters returns a warning message:
      """
      Stardates have to be a number.
      """

  Scenario: Stardates Must Be Four or Five Characters
    * a stardate with less than four numbers returns a warning message:
      """
      Stardates must be four (TOS) or five (TNG) digits.
      """

  Scenario: Stardates Must Be Four or Five Characters
    * a stardate with something strange returns a warning message:
      """
      Stardates must be four (TOS) or five (TNG) digits.
      """
