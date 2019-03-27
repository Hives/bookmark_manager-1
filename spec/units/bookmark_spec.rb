require "bookmark"
require 'pg'

describe Bookmark do
  describe "#all" do
    it "returns all bookmarks" do
      bookmark = Bookmark.add(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      Bookmark.add(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
      Bookmark.add(url: 'http://www.google.com', title: "Google")
      persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq persisted_data.first['id']
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'

    end
  end

  describe "#add" do
    it "adds a bookmark" do
      bookmark = Bookmark.add(url: "http://www.google.com", title: "Google")
      persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Google'
      expect(bookmark.url).to eq "http://www.google.com"
    end
  end

  describe "#delete" do
    it "deletes a bookmark" do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.add(url: "http://www.google.com", title: "Google")
      Bookmark.add(url: "http://www.facebook.com", title: "Facebook")
      
      Bookmark.delete(bookmark.id)
      
      expect(connection.exec( "SELECT * FROM bookmarks WHERE title = 'Facebook'").count).to eq 1
      expect(connection.exec( "SELECT * FROM bookmarks WHERE title = 'Google'").count).to eq 0
    end
  end


end
