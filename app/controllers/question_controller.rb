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

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = Answer.where("question_id = '#{params[:id]}'")
  erb :question_and_answers
end

post '/questions/:id' do
  @question = Question.find(params[:id])
  @user = User.find(session[:user_id])
  @new_vote = Vote.create(user_id: @user.id, target: @question, value: 1)

  if @new_vote.valid?
    if request.xhr?
      return @question.votes.count.to_s
    else
      erb :question_and_answers
    end
  else
    status 422
  end
end
