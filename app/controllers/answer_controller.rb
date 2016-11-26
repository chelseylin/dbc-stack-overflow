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

post "/question/:id/answers/:answer_id" do
	answer = Answer.find(params[:answer_id])
	puts "ANSWER ID OF FOUND ANSWER: #{answer.id}"
	puts "ANSWER BEST VALUE: #{answer.best_answer}"
	answer.update_attribute(:best_answer, 1)
	answer.save
	puts "ANSWER BEST VALUE AFTER INCREMENT: #{answer.best_answer}"
	puts "answer should be bested"
	redirect "/questions/#{params[:id]}"
end
