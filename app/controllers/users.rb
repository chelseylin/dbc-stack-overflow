# get '/' do
# 	erb :home
# end

get '/user_profile/:id' do
	@user = User.find(params[:id])
	@questions = @user.questions
	@total_post_karma = 0
	@total_answer_karma = @user.answers.each {|answer| @total_post_karma += answer.vote_count}
	@total_comment_karma = @user.comments.each {|comment| @total_post_karma += comment.vote_count}
	@total_question_karma = @user.questions.each {|question| @total_post_karma += question.vote_count}
	@topQuestion = (@questions.sort_by {|question| question.vote_count}).reverse![0]
	@lowQuestion = (@questions.sort_by {|question| question.vote_count})[0]
	erb :other_user_profile
end

post '/register' do
	@user = User.new(params[:user])
  @user.password = params[:password]

  if @user.save
  	session[:user_id] = @user.id
    redirect '/profile'
  else
    @errors = @user.errors.full_messages
    erb :error
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
  @user = User.find(session[:user_id])
	erb :user_profile
end

get '/logout' do
  session.delete(:user_id)
  redirect '/'
end
