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
post "/comments/:c_id/vote" do
  @comment = Comment.find(params[:c_id])
  @user = User.find(session[:user_id])


  vote_count = @comment.vote_count
  p params[:value]
  if request.xhr?
    if params[:value].to_i == 1
      value = 1
    else
      value = -1
    end
    # if params[:value].to_i == 0
    #   value = 1
    # else
    #   value = -1
    # end
    @new_vote = Vote.create!(user_id: @user.id, target: @comment, value: value)
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


#destroy
