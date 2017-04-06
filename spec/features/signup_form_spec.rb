feature 'Signup form' do
  scenario 'allows user to signup' do
    visit '/signup'
    fill_in(:email, with: 'echai93@gmail.com')
    fill_in(:password, with: 'brocolli')
    click_button 'Submit'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome echai93@gmail.com'
    expect(page).to have_content 'You are user number: 1'
  end
end
