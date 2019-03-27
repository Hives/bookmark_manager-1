require 'pg'

class Bookmark

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec( "SELECT * FROM bookmarks")
    # result.map { |bookmark| { :url => bookmark["url"], :title => bookmark["title"] } }
    result.map do |bookmark|
      self.new(id: bookmark["id"],
               title: bookmark["title"],
               url: bookmark["url"])
    end
  end

  def self.add(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'],
                 title: result[0]['title'], 
                 url: result[0]['url'] )
  end

  def self.delete(id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    connection.exec("DELETE FROM bookmarks WHERE id = #{id};")

  end

  attr_reader :id, :title, :url
  
  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end



end
