require 'capybara/rspec'

RSpec.describe 'Authenticating', type: :system do
  before :each do
    User.create(name: 'Taps', email: 'tapsysync@outlook.com', password: 'tapstapstapsy')
  end

  it 'signs in the user' do
    visit '/users/sign_in'
    sleep(1)

    within('#new_user') do
      fill_in 'Email', with: 'tapsysync@outlook.com'
      fill_in 'Password', with: 'tapstapstapsy'
    end

    sleep(1)
    click_button 'Log in'

    sleep(2)
    expect(page).to have_content 'Signed in successfully'
  end
end
