Given(/^(?:a|an|the) (.*) user can (?:log|sign) in to the application$/) do |type|
  on_visit(Home).login_as_user(type)
end

Given(/^an authenticated user on the planets page$/) do
  on_visit(Home).login_as_authenticated_user

  # One way to navigate
  on(Navigation).navigate.to_planet_page

  # Another way to do it.
  #on(Navigation).navigate_to("planet weight calculator")
end

Given(/^an authenticated user on the warp travel page$/) do
  on_visit(Home).login_as_authenticated_user
  on(Navigation).navigate.to_warp_travel_page
end

Given(/^an authenticated user on the stardate page$/) do
  on_visit(Home).login_as_authenticated_user
  on(Navigation).navigate.to_stardate_page

  # Another way to do it.
  #on(Navigation).navigate_to("stardate calculator")
end

Given(/^an authenticated user on the overlord page$/) do
  on_visit(Home).login_as_authenticated_user
  on(Navigation).navigate.to_overlord_page
end
