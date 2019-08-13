class Planet
  include Testable

  text_field :weight,    id: 'wt'
  text_field :mercury,   id: 'outputmrc'
  text_field :venus,     id: 'outputvn'
  text_field :mars,      id: 'outputmars'
  text_field :jupiter,   id: 'outputjp'
  text_field :saturn,    id: 'outputsat'
  text_field :uranus,    id: 'outputur'
  text_field :neptune,   id: 'outputnpt'
  text_field :pluto,     id: 'outputplt'

  button     :calculate, id: 'calculate'

  def convert(value)
    weight.set value
    calculate.click
  end

  def confirm_weight_on(planet)
    weight = self.send("#{planet}".downcase).value
  end

  def confirm_weight_calculation(planet, body_weight)
    result = body_weight.to_i * find_surface_gravity_ratio_for(planet)
    expect(send("#{planet}".downcase).value.to_f).to be_within(0.9).of(result)
  end

  # Query Methods

  def a_weight_of(weight)
    @weight = weight
    self
  end

  def is_what_on(planet)
    @weight * find_surface_gravity_ratio_for(planet)
  end

  # Model Execution

  G = 6.674e-11
  EARTH_SG = 9.81

  EARTH = { mass: 5.97e24, radius: 6.378e6 }
  MERCURY = { mass: 3.301e23, radius: 2.44e6 }
  VENUS = { mass: 4.8673e24, radius: 6.051e6 }
  MARS = { mass: 6.4169e23, radius: 3.397e6 }
  JUPITER = { mass: 1.8981e27, radius: 7.1492e7 }
  SATURN = { mass: 5.6832e26, radius: 6.0268e7 }
  URANUS = { mass: 8.6810e25, radius: 2.5559e7 }
  NEPTUNE = { mass: 1.0241e26, radius: 2.4764e7 }

  def find_surface_gravity_ratio_for(planet)
    force = G * self.instance_eval("#{planet.upcase}[:mass]")
    distance = self.instance_eval("#{planet.upcase}[:radius]")**2
    equator_sg = force / distance
    ratio = equator_sg / EARTH_SG
  end
end
