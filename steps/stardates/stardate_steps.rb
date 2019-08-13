When("the tng stardate {string} is converted") do |value|
  on(Stardate).convert_tng_stardate(value)
  @actual = on(Stardate).calculate_tng_stardate(value)
end

When("the tng stardate {string} is converted with leap year") do |value|
  on(Stardate).convert_tng_stardate_with_leap_year(value)
end

When("the tng era {float} is converted") do |value|
  on(Stardate).convert_tng_stardate(value)
  @actual = on(Stardate).calculate_tng_stardate(value)
end

When("converting a tos era stardate") do
  on(Stardate).set_tos_era
end

Then("the displayed and calculated calendar year should be {int}") do |expected_year|
  expect(@context.displayed_calendar_date).to include(expected_year.to_s)
  expect(@actual.year).to eq(expected_year)
end

Then("the displayed calendar response should contain {string}") do |date|
  expect(@context.displayed_calendar_date).to include(date)
end

Then("the calculated calendar year should be {string}") do |expected_year|
  expect(@actual.year).to eq(expected_year.to_i)
end

Then("the calculated calendar month sould be {string}") do |expected_month|
  expect(@actual.month_name).to eq(expected_month)
end

Then("the calculated calendar day should be {string}") do |expected_day|
  expect(@actual.day).to eq(expected_day.to_i)
end

Then(/^there are nine facts listed by default$/) do
  puts on(Stardate).facts.text.as_list
end

Then(/^a blank stardate returns a warning message:$/) do |expected_message|
  on(Stardate).convert_tng_stardate('')
  expect(@context.error_message).to eq(expected_message)
end

Then(/^a stardate with (.*) returns a warning message:$/) do |condition, expected_message|
  value = on(Stardate).calculate_invalid_stardate(condition)
  expect(@context.error_message).to eq(expected_message)
  condition_reporter(value)
end

Then("there is no option to calculate stardates per year") do
  on(Stardate).verify_no_per_year_option
end

Then(/^TOS conversions do not have a leap year option$/) do
  on(Stardate) do |action|
    action.set_tos_era
    action.verify_no_per_year_option
  end
end
