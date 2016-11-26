# Users

user1 = User.create(user_name: "tester_1", password: "123456")
user2 = User.create(user_name: "tester_2", password: "123456")
user3 = User.create(user_name: "tester_3", password: "123456")

# Questions

question1 = Question.create(title: "test question 1", description: "blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah ", user_id: 1)
question2 = Question.create(title: "test question 2", description: "blah", user_id: 1)
question3 = Question.create(title: "test question 3", description: "blah", user_id: 2)
question4 = Question.create(title: "test question 4", description: "blah", user_id: 2)
question5 = Question.create(title: "test question 5", description: "blah", user_id: 3)
question6 = Question.create(title: "test question 6", description: "blah", user_id: 3)

# Answers

answer1 = Answer.create(description: "answer 1", user_id: 2, question_id: 1, best_answer: 1)
answer2 = Answer.create(description: "answer 2", user_id: 3, question_id: 1)
answer3 = Answer.create(description: "answer 3", user_id: 2, question_id: 2)
answer4 = Answer.create(description: "answer 4", user_id: 3, question_id: 2)
answer5 = Answer.create(description: "answer 5", user_id: 1, question_id: 3)
answer6 = Answer.create(description: "answer 6", user_id: 3, question_id: 3)
answer7 = Answer.create(description: "answer 7", user_id: 1, question_id: 4)
answer8 = Answer.create(description: "answer 8", user_id: 2, question_id: 5)
answer9 = Answer.create(description: "answer 9", user_id: 2, question_id: 6)

# Comments

comment1 = Comment.create(description: "comment for question", user_id: 2, content: question1)
comment1 = Comment.create(description: "comment for answer", user_id: 2, content: answer1)

# Votes

vote1 = Vote.create(value: 1, user_id: 2, target: question1)
vote2 = Vote.create(value: 1, user_id: 3, target: answer1)
vote3 = Vote.create(value: 1, user_id: 1, target: comment1)
vote4 = Vote.create!(value: -1, user_id: 4, target: question1)
