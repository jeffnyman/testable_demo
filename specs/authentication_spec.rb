RSpec.describe "Authentication" do
  it "an admin user can log in to the application" do
    on_view(Home).login_as_user("admin")
  end

  it "the tester user can log in to the application" do
    on_view(Home).login_as_user("tester")
  end

  it "an authenticated user can log in to the application" do
    on_view(Home).login_as_user("authenticated")
  end
end
