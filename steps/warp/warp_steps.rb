Given("a basic trip to {string} takes {float} years") do |location, time|
  on(WarpTravel).confirm_basic_trip_for(location).is(time)
end
