require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :method_override 

  get "/" do
    erb :index
  end

  get "/bookmarks" do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end
  
  get "/bookmarks/add" do
    erb :'bookmarks/add'
  end

  post "/bookmarks" do
    p params
    Bookmark.add(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete "/bookmarks/:id" do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
