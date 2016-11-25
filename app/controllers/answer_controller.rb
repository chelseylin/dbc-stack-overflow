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
