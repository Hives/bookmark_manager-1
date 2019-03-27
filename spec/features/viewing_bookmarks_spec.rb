require 'pg'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    Bookmark.add("http://www.makersacademy.com", "Makers Academy")
    Bookmark.add("http://www.google.com", "Google")

    visit('/bookmarks')

    expect(page).to have_link("Makers Academy", href: "http://www.makersacademy.com")
    expect(page).to have_link("Google", href: "http://www.google.com")
  end
end