# frozen_string_literal: true

class LoginPage < SitePrism::Page
  set_url 'http://the-internet.herokuapp.com/login'

  # NOTE: We create these as collections (altho we expect only one of each) so that we can verify expectation
  elements :username_input, 'input[name=username]'
  elements :password_input, 'input[name=password]'
  elements :submit_button,  'button[type=submit]'

  def login_with_valid_credentials
    username_input[0].set 'tomsmith'
    password_input[0].set 'SuperSecretPassword!'
    submit_button[0].click
  end
end
