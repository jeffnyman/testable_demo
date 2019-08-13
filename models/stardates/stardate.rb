class Stardate
  include Testable
  include DataAccessible

  data_load "#{File.dirname(__FILE__)}/../../data/stardates/stardate_conditions.yml"

  element :enable_form,   id: 'enableForm'
  element :leap_year,     id: 'stardatesWithLeapYear'
  element :tng_era,       id: 'tngEra'
  element :tos_era,       id: 'tosEra'
  element :stardate,      id: 'stardateValue'
  element :calendar_date, id: 'calendarValue'
  element :convert,       id: 'convert'
  label   :error,         class: 'val-error'

  element :logo,          id: 'stardate-logo'
  element :stardate_form, id: 'computeStardate'

  page_ready { [logo.exists?, "Stardate logo is not present"] }
  page_ready { [stardate_form.exists?, "Stardate form is not present"] }

  ul   :facts, id: 'fact-list'
  span :fact, -> { facts.span(class: 'site-item')}

  def convert_tng_stardate(value)
    set_tng_era
    set_stardate(value)
    convert.click
  end

  def convert_tng_stardate_with_leap_year(value)
    set_tng_era_leap_year
    set_stardate(value)
    convert.click
  end

  def set_tng_era
    enable_stardate_form
    tng_era.set
    expect(tng_era.set?).to be_truthy
  end

  def set_tos_era
    enable_stardate_form
    tos_era.set
    expect(tos_era.set?).to be_truthy
  end

  def set_tng_era_leap_year
    set_tng_era
    leap_year.set
    expect(leap_year.set?).to be_truthy
  end

  def enable_stardate_form
    enable_form.set
    expect(enable_form.set?).to be_truthy
  end

  def displayed_calendar_date
    calendar_date.value
  end

  def set_stardate(value)
    stardate.set value
    expect(stardate.value.to_s).to eq(value.to_s)
  end

  def verify_no_per_year_option
    expect(leap_year.visible?).to be_falsy
  end

  def error_message
    # Chrome
    # expect(error.style('color')).to eq('rgba(255, 255, 255, 1)')

    expect(error.style('color')).to eq('rgb(255, 255, 255)')
    error.text
  end

  def calculate_invalid_stardate(condition)
    found_condition = data_conditions(condition)

    raise PossibleDataContextError,
      "The condition specified (#{condition}) is not recognized." if not found_condition

    case condition
      when 'only letters'
        data_condition = 'abcde'
      when 'some letters'
        data_condition = '581ab'
      when 'less than four numbers'
        data_condition = '58'
    end

    convert_tng_stardate(data_condition)
    data_condition
  end

  # Model of Stardate Calculation

  def calculate_tng_stardate(value)
    require 'time'

    stardates_per_year = value.to_f * 34367056.4
    origin = Time.new(2318, 7, 5, 12, 0, 0)
    milliseconds = ((origin.to_f * 1000).to_i) + stardates_per_year
    result = Time.at(milliseconds/1000.0).strftime("%Y-%m-%d %H:%M.%S")
    calendar = DateTime.parse(result).to_date
  end

  private

  def data_conditions(condition)
    self.class.stardate.invalid.conditions.each do |cond|
      return cond if cond == condition
    end
    nil
  end
end
