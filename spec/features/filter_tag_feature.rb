feature 'filter tags' do
  scenario 'filter links by tag' do
    visit '/links/new'
    fill_in(:name, with: 'Makers Academy')
    fill_in(:url, with: 'http://www.makersacademy.com')
    fill_in(:tags, with: 'coding')
    click_button 'Submit'
    visit '/links/new'
    fill_in(:name, with: 'Barry')
    fill_in(:url, with: 'http://www.barrywhite.org')
    fill_in(:tags, with: 'Sexy AF music')
    click_button 'Submit'
    visit '/tag/coding'
    expect(page).to have_content 'Makers Academy'
    expect(page).not_to have_content 'Barry'
  end
end
