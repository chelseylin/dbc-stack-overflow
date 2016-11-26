#index
#new
#create
#show
#edit
#update
#destroy

get '/' do
  redirect '/questions'
end

get '/questions' do
  @questions = Question.all
  @timestamps = @questions.to_a.map do |question|
    question.created_at.strftime('%a %d %b %Y')
  end
  erb :index
end

get '/questions/new' do
  if session[:user_id]
    erb :create_question
  else
    # enable javascript alert
    redirect '/questions'
  end
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = Answer.where("question_id = '#{params[:id]}'")
  erb :question_and_answers
end

post '/questions/new' do
  @question = Question.create!(title: params[:title], description: params[:description], user_id: session[:user_id])

  redirect '/questions'
end

post '/questions/:id' do
  @question = Question.find(params[:id])
  @user = User.find(session[:user_id])

  if request.xhr?
    if params[:value].to_i == 0
      value = 1
    else
      value = -1
    end
    @new_vote = Vote.create!(user_id: @user.id, target: @question, value: value)
    if @new_vote.save
      return @question.vote_count.to_s
    end
  else
    erb :question_and_answers
  end
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = Answer.where("question_id = '#{params[:id]}'")
  erb :show_question
end


