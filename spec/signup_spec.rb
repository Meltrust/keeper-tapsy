require 'capybara/rspec'

RSpec.describe 'Signing up', type: :system do
  it 'signs up the user' do
    visit '/users/sign_up'
    sleep(1)

    within('#new_user') do
      fill_in 'Name', with: 'testy1user'
      fill_in 'Email', with: 'testy1@outlook.com'
      fill_in 'Password', with: 'tapstapstapsy'
      fill_in 'Password confirmation', with: 'tapstapstapsy'
    end

    sleep(1)
    click_button 'Sign up'

    sleep(2)
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
