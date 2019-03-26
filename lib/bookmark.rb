require 'pg'

class Bookmark

  def self.view_all
    urls = []
    conn = PG.connect( dbname: 'bookmark_manager')
    result = conn.exec( "SELECT * FROM bookmarks")
    result.map { |bookmark| bookmark["url"] } 
  end
end