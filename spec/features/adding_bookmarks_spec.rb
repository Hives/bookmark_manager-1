require 'pg'

feature 'Adding bookmarks' do
  scenario 'from the add bookmarks page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit('/bookmarks/add')
    fill_in 'url', with: "http://www.google.com"
    fill_in 'title', with: "Google"
    click_button 'Add'
    expect(page).to have_content 'Google'
  end
end
