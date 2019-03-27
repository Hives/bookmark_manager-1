require 'pg'

feature 'Deleting bookmarks' do
  scenario 'from the delete bookmarks page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.google.com', 'Google') RETURNING id, title, url;")
    id = result[0]['id']
    visit('/bookmarks/delete')
    find("#delete-item-#{id}").click
    expect(connection.exec( "SELECT * FROM bookmarks WHERE id = #{id}").count).to eq 0
  end
end