#index
#new
#create
#show
#edit
#update
#destroy
post "/question/:id/answers" do
  # userid_who_posedQ = User.find_by(question_id: params[:id]
  Answer.create!(description: params[:answertext], user_id: session[:user_id], question_id: params[:id])
  redirect "/questions/#{params[:id]}"
end

post "/answers/:a_id/vote" do
  @answer = Answer.find(params[:a_id])
  @user = User.find(session[:user_id])

  vote_count = @answer.vote_count
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
    @new_vote = Vote.create!(user_id: @user.id, target: @answer, value: value)
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