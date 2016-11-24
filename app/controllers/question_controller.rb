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