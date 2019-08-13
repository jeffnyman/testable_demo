class Home
  include Testable

  url_is    Config.context["url"]
  title_is  "Veilus"

  element :logo, id: 'site-image'

  element :login_form, id: 'open'
  element :username,   id: 'username'
  element :password,   id: 'password'
  element :login,      id: 'login-button'
  element :message,    class: 'notice'

  # If you wanted to use more specific element names rather
  # than the generic `element`, as above, you can do so.

  # p          :login_form, id: 'open'
  # text_field :username,   id: 'username'
  # text_field :password,   id: 'password'
  # button     :login,      id: 'login-button'
  # div        :message,    class: 'notice'

  page_ready { [logo.exists?, "Test Gorilla logo is not present"] }

  def begin_with
    move_to(0, 0)
    resize_to(screen_width, screen_height)
  end

  def login_as_user(type)
    # You could the following commented out statement instead of wrapping
    # the statements with the `when_ready` block.
    #
    # check_if_ready

    when_ready do
      type = Config.context(Config.current.user)['username'] if type == "authenticated"

      login_form.click
      username.set Config.context(type)['username']
      password.set Config.context(type)['password']
      login.click

      expect(message.text).to eq(Config.context(type)['message'])
    end
  end

  def login_as_authenticated_user
    login_as_user("authenticated")
  end
end
