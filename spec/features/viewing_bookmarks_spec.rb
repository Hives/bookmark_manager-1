require 'pg'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    Bookmark.add(url: "http://www.makersacademy.com", title: "Makers Academy")
    Bookmark.add(url: "http://www.google.com", title: "Google")

    visit('/bookmarks')

    expect(page).to have_link("Makers Academy", href: "http://www.makersacademy.com")
    expect(page).to have_link("Google", href: "http://www.google.com")
  end
end