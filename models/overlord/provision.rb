class Provision
  include Testable
  include DataAccessible

  data_load "#{File.dirname(__FILE__)}/../../data/overlord/invalid_provision_messages.yml"

  element :activation_code,   id: "activation-code"
  element :deactivation_code, id: "deactivation-code"
  element :countdown_value,   id: "countdown-value"
  element :provision_bomb,    id: "provision-bomb"
  element :provision_error,   id: "provision-error"

  def create_bomb(options = {})
    activation_code.set(options[:activate])     if options[:activate]
    deactivation_code.set(options[:deactivate]) if options[:deactivate]
    countdown_value.set(options[:countdown])    if options[:countdown]
    provision_bomb.click
  end

  def confirm_invalid_activation_message
    message = error_message
    expect(message).to eq(activation_error_message)
    message
  end

  def confirm_invalid_deactivation_message
    message = error_message
    expect(message).to eq(deactivation_error_message)
    message
  end

  def confirm_invalid_countdown_message
    message = error_message
    expect(message).to eq(countdown_error_message)
    message
  end

  def activation_error_message
    invalid_data_condition("activation-code")
  end

  def deactivation_error_message
    invalid_data_condition("deactivation-code")
  end

  def countdown_error_message
    invalid_data_condition("countdown-value")
  end

  def error_message
    provision_error.text
  end

  private

  def invalid_data_condition(condition)
    self.class.invalid.provision.each do |cond|
      return cond[1][0] if cond[0] == condition
    end
    nil
  end
end
