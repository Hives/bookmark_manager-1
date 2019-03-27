require 'pg' 

def setup_test_database

  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("DROP TABLE IF EXISTS bookmarks;")
  connection.exec("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));")

end