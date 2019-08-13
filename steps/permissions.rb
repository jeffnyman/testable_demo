Given("overlord cannot be viewed by a tester user") do
  on_visit(Home).login_as_user("tester")
  on(Navigation).navigate.to_overlord_page(expect_fail: true)
end

Given(/^overlord can be viewed by an admin user$/) do
  on_visit(Home).login_as_user("admin")
  on(Navigation).navigate.to_overlord_page
end
