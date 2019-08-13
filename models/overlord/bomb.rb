class Bomb
  include Testable
  include DataAccessible

  data_load "#{File.dirname(__FILE__)}/../../data/overlord/bomb_messages.yml"

  element :timer_display_value, id: "timer-output"
  element :timer_active,        id: "timer-started"
  element :timer_value,         id: "timer-countdown"
  element :trigger_code,        id: "trigger-code"
  element :bomb_status,         id: "bomb-status"
  element :bomb_state,          id: "change-bomb-state"
  element :detonation,          id: "detonation"
  element :notice,              id: "flash"

  element :zero,   data_value: "0"
  element :one,    data_value: "1"
  element :two,    data_value: "2"
  element :three,  data_value: "3"
  element :four,   data_value: "4"
  element :five,   data_value: "5"
  element :six,    data_value: "6"
  element :seven,  data_value: "7"
  element :eight,  data_value: "8"
  element :nine,   data_value: "9"
  element :delete, id: "trigger-delete"

  def enter_code(code)
    trigger_code.set(code)
    self
  end

  def enter_code_in_keypad(code)
    value = code.split("")
    value.each do |number|
      send("#{value[number.to_i - 1].to_i.to_words}").click
    end
    self
  end

  def delete_code
    1.upto(trigger_code.value.size) do
      delete.click
    end
  end

  def confirm_empty_code
    expect(trigger_code.value.size).to eq(0)
  end

  def activate_bomb
    bomb_state.click
  rescue Selenium::WebDriver::Error::UnknownError
    bomb_state.focus
    bomb_state.send_keys :enter
  end

  alias deactivate_bomb  activate_bomb

  # Countdown State

  def countdown_value_is(seconds)
    value = timer_display.split(":")[1]
    expect(value.to_i).to eq(seconds) if timer_value_in_seconds == value
  end

  def countdown_has_started
    expect(timer_state).to eq('true')
  end

  def countdown_has_stopped
    expect(timer_state).to eq('false')
  end

  def countdown_has_finished
    t1 = Time.now
    duration = perform_countdown
    t2 = Time.now
    expect((t2 - t1).round).to eq(duration.to_i)
  end

  def confirm_countdown_cannot_be_changed
    expect(timer_display_value).not_to be_enabled
  end

  # Bomb State

  def confirm_detonation
    expect(detonation.wait_until(&:dom_updated?)).to be_present
    # expect(detonation).to be_present
  end

  def confirm_inactive_bomb_state
    message = bomb_status.text
    expect(message).to eq(inactive_bomb_message)
    message
  end

  def confirm_active_bomb_state
    message = bomb_status.text
    expect(message).to eq(active_bomb_message)
    message
  end

  def inactive_bomb_message
    bomb_message_condition("inactive")
  end

  def active_bomb_message
    bomb_message_condition("active")
  end

  # Bomb Messages

  def confirm_incorrect_activation_message
    message = bomb_message
    expect(message).to eq(incorrect_activation_message)
    message
  end

  def confirm_incorrect_deactivation_message
    message = bomb_message
    expect(message).to eq(incorrect_deactivation_message)
    message
  end

  def confirm_invalid_activation_message
    message = bomb_message
    expect(message).to eq(invalid_activation_message)
    message
  end

  def confirm_invalid_deactivation_message
    message = bomb_message
    expect(message).to eq(invalid_deactivation_message)
    message
  end

  def incorrect_activation_message
    bomb_message_condition("incorrect-activation")
  end

  def incorrect_deactivation_message
    bomb_message_condition("incorrect-deactivation")
  end

  def invalid_activation_message
    bomb_message_condition("invalid-activation")
  end

  def invalid_deactivation_message
    bomb_message_condition("invalid-deactivation")
  end

  def bomb_message
    notice.text
  end

  # Timer State

  def timer_display
    timer_display_value.value
  end

  def timer_state
    timer_active.value
  end

  def timer_value_in_seconds
    timer_value.value
  end

  # Connectors

  def then
    self
  end

  def check_that
    self
  end

  private

  def bomb_message_condition(message)
    self.class.bomb.messages.each do |msg|
      return msg[1][0] if msg[0] == message
    end
    nil
  end

  def perform_countdown
    time_left = timer_value_in_seconds

    (time_left.to_i + 1).downto(1) do |n|
      puts n.to_s.yellow
      sleep 1
    end
  end
end
