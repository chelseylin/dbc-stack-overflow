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

  erb :create_question
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = Answer.where("question_id = '#{params[:id]}'")
  erb :show_question
end

post '/questions/new' do
  @question = Question.create!(title: params[:title], description: params[:description], user_id: session[:user_id])

  redirect '/questions'
end