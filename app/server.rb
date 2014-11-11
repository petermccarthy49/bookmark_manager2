require 'sinatra'
require 'data_mapper'

require './lib/link' # this needs to be done after datamapper is initialised
require './lib/tag'
require './lib/user'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set    :session_secret, 'super secret'


get '/' do
  @links = Link.all
  erb :index
end

post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map do |tag|
    Tag.first_or_create(:text => tag) # either finds or creates the tag
  end
  Link.create(:url => url, :title => title, :tags => tags)
  redirect to('/')
end

get '/tags/:text' do
  tag =Tag.first(:text => params[:text])
  @links = tag ? tag.links : []
  erb :index
end

get '/users/new' do
  erb :"users/new" # we use "quotes" otherwise ruby would divide symbol :users by the var new
end

post '/users' do
  user = User.create(:email => params["email"],
                    :password => params["password"])
  session[:user_id] = user.id
  redirect to('/')
end



