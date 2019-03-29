require 'pg'

class Bookmark

  def self.connection
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    connection
  end

  def self.all
    result = connection.exec("SELECT * FROM bookmarks")
    result.map do |bookmark|
      new(id: bookmark["id"], title: bookmark["title"], url: bookmark["url"])
    end
  end

  def self.add(url:, title:)
    result = connection.exec("INSERT INTO bookmarks (url, title)
                              VALUES ('#{url}', '#{title}')
                              RETURNING id, title, url;")

    new(id: result[0]["id"], title: result[0]["title"], url: result[0]["url"])
  end

  def self.delete(id)
    connection.exec("DELETE FROM bookmarks WHERE id = #{id};")
  end

  attr_reader :id, :title, :url
  
  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end



end
