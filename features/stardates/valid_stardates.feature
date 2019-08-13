Feature: Calculate Stardates

  The stardate calculator allows for converting a stardate from the "TOS Era"
  or the "TNG era".

  "TOS" refers to "The Original Series".
  "TNG" refers to "The Next Generation".

  Voyager and Deep Space Nine are considered to be in the TNG Era.
  The stardate system was not in place for the Enterprise series.

  It is unknown if the upcoming Discovery series will use the stardate
  scheme, although this is likely as it is set ten years before TOS.

  Background:
    Given an authenticated user on the stardate page

  Scenario: Convert Valid TNG Stardate (Display)
    When the tng stardate "54868.6" is converted
    Then the displayed calendar response should contain "Thu Apr 06 2378"

  Scenario: Convert Valid TNG Stardate (Model)
    When the tng stardate "54868.6" is converted
    Then the calculated calendar year should be "2378"
    And  the calculated calendar month sould be "April"
    And  the calculated calendar day should be "6"

  Scenario: Convert Valid TNG Stardate (with Leap Year)
    When the tng stardate "54868.6" is converted with leap year
    Then the displayed calendar response should contain "Mon, 14 Nov 2377"

  Scenario Outline: Convert Valid TNG Era Stardates
    When the tng era <stardate> is converted
    Then the displayed and calculated calendar year should be <year>

    Examples:
      | stardate | year | comment      |
      | 46379.1  | 2369 | DS9 begins   |
      | 48315.6  | 2371 | VOY begins   |
      | 56844.9  | 2380 | TNG: Nemesis |

  Scenario: TOS Conversions Have No Leap Year Calculation
    When converting a tos era stardate
    Then there is no option to calculate stardates per year

  Scenario: TOS Conversions Have No Leap Year Calculation (Business Rule)
    * TOS conversions do not have a leap year option
