
get '/users/new' do
  @user = User.new
  erb :"users/new" # we use "quotes" otherwise ruby would divide symbol :users by the var new
end


post '/users' do
  @user = User.create(:email => params["email"],
                    :password => params["password"],
                    :password_confirmation => params["password_confirmation"])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"users/new"
  end
end

get '/users/reset' do
  @user = User.new
  erb :"users/reset"
end

post '/users/reset' do
  email = params[:email]
  @user = User.first(:email => params[:email])
  if @user
    token = create_new_token
    @user.update(password_token: token,
                password_token_timestamp: create_new_timestamp)
    send_email(@user, token)
    "Password reset link sent to your email address"
    redirect to '/'
  else
    flash[:errors] = ["Sorry, #{email} is not registered. Please sign up first!"]
    redirect to '/users/reset'
  end
end

def create_new_token
  (1..64).map{('A'..'Z').to_a.sample}.join
end

def create_new_timestamp
  Time.now
end

get '/users/reset_password/:token' do
  @token = params[:token]
  erb :"users/reset_password"
end

post '/users/reset_password' do
  token = params[:token]
  user = User.first(password_token: token)
  user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
  flash[:notice] = "Password changed"
  redirect to('/')
end





