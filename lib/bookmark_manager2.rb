require 'sinatra/base'

class BookmarkManager2 < Sinatra::Base
  get '/' do
    'Hello bookmark_manager2!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
