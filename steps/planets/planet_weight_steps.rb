When("the weight calculated is {int}") do |pounds|
  @weight = pounds
  on(Planet).convert(pounds)
end

Then("the weight on {word} will be exactly {float}") do |planet, weight|
  on(Planet).confirm_weight_on(planet).is(weight)
  on(Planet).confirm_weight_on(planet).is_displayed_as(weight)
  on(Planet).confirm_weight_calculation(planet, @weight)
end

Then("the weight on {word} will be roughly {int}") do |planet, weight|
  on(Planet).confirm_weight_on(planet).is_roughly(weight)
end

Then("a {int} pound person will weigh exactly {float} pounds on {word}") do |pounds, weight, planet|
  on(Planet).convert(pounds)
  on(Planet).confirm_weight_on(planet).is(weight)
end

Then("a {int} pound person will weigh approximately {int} pounds on {word}") do |pounds, weight, planet|
  on(Planet).convert(pounds)
  on(Planet).confirm_weight_on(planet).is_roughly(weight)
end

Then("a weight of {int} is what on {word}?") do |pounds, planet|
  puts on(Planet).a_weight_of(pounds).is_what_on(planet)
end
