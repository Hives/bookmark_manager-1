require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions

  get "/" do
    erb :index
  end

  get "/bookmarks" do
    @bookmarks = Bookmark.view_all
    erb :bookmarks
  end
  
  get "/bookmarks/add" do
    erb :'bookmarks/add'
  end

  post "/bookmarks/add" do
    p params
    Bookmark.add(params[:url], params[:title])
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
