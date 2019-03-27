require "bookmark"
require 'pg'

describe Bookmark do
  describe "#view_all" do
    it "returns all bookmarks" do
      Bookmark.add('http://www.makersacademy.com', 'Makers Academy')
      Bookmark.add('http://www.google.com', "Google")

      bookmarks = Bookmark.view_all

      expect(bookmarks).to include( { :url => "http://www.makersacademy.com", :title => "Makers Academy" } )
      expect(bookmarks).to include( { :url => "http://www.google.com", :title => "Google" } )
    end
  end

  describe "#add" do
    it "adds a bookmark" do
      Bookmark.add("http://www.google.com", "Google")
      bookmarks = Bookmark.view_all
      expect(bookmarks).to include( { :url => "http://www.google.com", :title => "Google" } )
    end
  end


end
