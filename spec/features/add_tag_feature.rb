feature 'add tags' do
  scenario 'add a single tag to a link' do
    visit '/links/new'
    fill_in(:name, with: 'Makers Academy')
    fill_in(:url, with: 'http://www.makersacademy.com')
    fill_in(:tags, with: 'coding')
    click_button 'Submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('coding')
  end
end
