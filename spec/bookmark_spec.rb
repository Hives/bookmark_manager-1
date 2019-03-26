require "bookmark"

describe Bookmark do
  describe "#view_all" do
    it "returns all bookmarks" do
      bookmarks = Bookmark.view_all

      expect(bookmarks).to include('www.google.com')
      expect(bookmarks).to include('www.makers.tech')
      expect(bookmarks).to include('www.destroyallsoftware.com')
    end
  end
end
