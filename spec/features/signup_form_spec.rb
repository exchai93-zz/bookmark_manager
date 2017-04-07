feature 'Signup form' do
  scenario 'allows user to signup' do
    visit '/users/new'
    fill_in(:email, with: 'echai93@gmail.com')
    fill_in(:password, with: 'brocolli')
    fill_in(:password_confirmation, with: 'brocolli')
    click_button 'Submit'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome, echai93@gmail.com'
    expect(page).to have_content 'You are user number: 1'
  end

  scenario 'user enters mismatching password' do
    visit '/users/new'
    fill_in(:email, with: 'echai93@gmail.com')
    fill_in(:password, with: 'brocolli')
    fill_in(:password_confirmation, with: 'squash')
    click_button 'Submit'
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Password does not match the confirmation'
    expect(User.count).to eq 0
  end

  scenario 'user does not enter an email' do
    visit '/users/new'
    fill_in(:password, with: 'brocolli')
    fill_in(:password_confirmation, with: 'brocolli')
    click_button 'Submit'
    expect(current_path).to eq '/users'
    expect(User.count).to eq 0
    expect(page).to have_content('Email must not be blank')
  end

  scenario 'user enters invalid email' do
    visit '/users/new'
    fill_in(:email, with: 'echai93gmail')
    fill_in(:password, with: 'brocolli')
    fill_in(:password_confirmation, with: 'brocolli')
    click_button 'Submit'
    expect(current_path).to eq '/users'
    expect(User.count).to eq 0
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'user enters existing email' do
    User.create(email: 'echai93@gmail.com')
    visit '/users/new'
    fill_in(:email, with: 'echai93@gmail.com')
    fill_in(:password, with: 'brocolli')
    fill_in(:password_confirmation, with: 'brocolli')
    click_button 'Submit'
    expect(current_path).to eq '/users'
    expect(User.count).to eq 1
    expect(page).to have_content "Email is already taken"
  end
end
