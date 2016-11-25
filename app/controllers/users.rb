# get '/' do 
# 	erb :home
# end

post '/register' do
	@user = User.new(params[:user])
  @user.password = params[:password]
 
  if @user.save
  	session[:user_id] = @user.id
    redirect '/profile'
  else
    @errors = @user.errors.full_messages
    erb :index
  end
end

get '/login' do
	erb :login
end

post '/login' do
	@user = User.find_by(user_name: params[:username])
	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
		erb :user_profile
	else
		@errors = ["invalid user/password"]
		erb :login
	end
end

get '/profile' do
	erb :user_profile
end

get '/logout' do 
  session.delete(:user_id)
  redirect '/'
end