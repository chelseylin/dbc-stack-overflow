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
  if params[:order] == 'date'
    @questions = Question.all.sort_by { |question| question.created_at }.reverse!
  elsif params[:order] == 'view'
    @questions = Question.all.sort_by { |question| question.views }.reverse!
  else
    @questions = Question.all.sort_by { |question| question.vote_count }.reverse!
  end
  @timestamps = @questions.to_a.map do |question|
    question.created_at.strftime('%a %d %b %Y')
  end
  return erb :questions, layout: false if request.xhr?
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
  @question.views += 1
  @question.save
  @answers = Answer.where("question_id = '#{params[:id]}'")
  erb :question_and_answers
end

post '/questions/new' do
  @question = Question.create(title: params[:title], description: params[:description], user_id: session[:user_id])
  if @question.valid?
    Vote.create(value: 1, user_id: session[:user_id], target: @question)
    @question.votes
    redirect '/questions'
  else
    @errors = @question.errors.full_messages
    erb :create_question
  end
end

post '/questions/:id/vote' do
  @question = Question.find(params[:id])
  @user = User.find(session[:user_id])

  vote_count = @question.vote_count
  # puts "============"
  # p params[:value]

  
  if request.xhr?
    if params[:value].to_i == 1
      value = 1
    else
      value = -1
    end
    @new_vote = Vote.create!(user_id: @user.id, target: @question, value: value)
    if @new_vote.save
      return (vote_count + value).to_s
      # return @question.vote_count.to_s
    else
      status 422
      erb :question_and_answers
    end
  else
    erb :question_and_answers
  end
end

# get '/questions/:id' do
#   @question = Question.find(params[:id])
#   @answers = Answer.where("question_id = '#{params[:id]}'")
#   erb :show_question
# end


