# frozen_string_literal: true

require 'spec_helper'
require_relative 'login_steps'
require_relative 'site_prism/login_page'
require_relative 'site_prism/secure_area_page'

feature 'Login page' do
  let(:login_page) { LoginPage.new }

  scenario 'login page must have single visible username and password input fields and submit button' do
    user_goes_to_the_login_page
    there_must_be_a_single_visible(login_page.username_input)
    there_must_be_a_single_visible(login_page.password_input)
    there_must_be_a_single_visible(login_page.submit_button)
  end

  #### SUPPORT METHODS ###
  # TODO: This should probably be a common routine
  def there_must_be_a_single_visible(elements)
    expect(elements.count).to eq(1)
    the_element = elements[0]
    expect(the_element.visible?).to be true
  end
end
