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
