require 'pg'

feature 'Deleting bookmarks' do
  scenario 'from the delete bookmarks page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.google.com', 'Google') RETURNING id, title, url;")
    id = result[0]['id']
    title = result[0]['title']
    visit('/bookmarks')
    within("#bookmark-#{id}") { click_button "Delete bookmark" }
    expect(page).not_to have_content title
    # expect(page).to have_current_path('/bookmarks')
    # expect(connection.exec( "SELECT * FROM bookmarks WHERE id = #{id}").count).to eq 0
  end
end
