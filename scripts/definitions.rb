
class Home
  include Testable

  url_is "https://veilus.herokuapp.com/"
  url_matches(/heroku/)
  title_is "Veilus"

  # Elements can be defined with HTML-style names as found in Watir.
  p          :login_form, id:    "open", visible: true
  text_field :username,   id:    "username"
  text_field :password
  button     :login,      id:    "login-button"
  div        :message,    class: "notice"

  # Elements can be defined with a generic name as found in Capybara.
  # element :login_form, id:    "open", visible: true
  # element :username,   id:    "username"
  # element :password
  # element :login,      id:    "login-button"
  # element :message,    class: "notice"

  def begin_with
    move_to(0, 0)
    resize_to(screen_width, screen_height)
  end

  def login_as_admin
    login_form.click
    username.set "admin"
    password(id: 'password').set "admin"
    login.click
    expect(message.text).to eq('You are now logged in as admin.')
  end
end

class Navigation
  include Testable

  p     :page_list,     id: "navlist"
  link  :planets,       id: "planets"

  image :planet_logo,   id: "planet-logo"

  def go_to_planets_page
    page_list.click
    # page_list.wait_until(&:dom_updated?).click
    planets.click
    expect(planet_logo.exists?).to be true
  end
end

class WarpTravel
  include Testable
  include DataBuilder

  text_field :warp_factor, id: 'warpInput'
  text_field :velocity,    id: 'velocityInput'
  text_field :distance,    id: 'distInput'

  element :travel_au,   id: 'travelAU'
  element :travel_ly,   id: 'travelLY'
  element :travel_time, id: 'travelUser'

  DataBuilder.data_path = "#{File.dirname(__FILE__)}/../../data/warp"

  def confirm_basic_trip_for(location)
    DataBuilder.load('stars.yml')

    using(data_about(location))
    time = travel_time.text
  end
end
