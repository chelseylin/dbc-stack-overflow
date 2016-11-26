#index
#new
#create
post '/:content_type/:content_id/comment' do
  comment = Comment.create(description: params[:description], user_id: session[:user_id], content_type: params[:content_type][0..-2].capitalize, content_id: params[:content_id])
  if params[:content_type] == "answers"
    answer = Answer.find(params[:content_id])
    @question_id = answer.question_id
  else
    @question_id = params[:content_id]
  end

  redirect "/questions/#{@question_id}"
  # redirect "/#{params[:content_type]}/#{params[:content_id]}"
end
#show
get '/:content_type/:id/comment/new' do
  if session[:user_id]
    @content_type = params[:content_type]
    @content_id = params[:id]
    erb :create_comment
  else
    # insert javascript alert
    redirect '/questions'
  end
end

#edit
#update
#destroy
