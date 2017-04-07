feature 'User sign in' do
  scenario 'User successfully signs in' do
    visit '/users/new'
    fill_in(:email, with: 'echai93@gmail.com')
    fill_in(:password, with: 'brocolli')
    fill_in(:password_confirmation, with: 'brocolli')
    click_button 'Submit'
    visit '/sessions/new'
    fill_in(:email, with: 'echai93@gmail.com')
    fill_in(:password, with: 'brocolli')
    click_button 'Sign in'
    expect(current_path).to eq '/links'
  end

end
