# Users

user1 = User.create!(user_name: "tester_1", password: "abc123ab")
user2 = User.create!(user_name: "tester_2", password: "abc123ab")
user3 = User.create!(user_name: "tester_3", password: "abc123ab")
user4 = User.create!(user_name: "tester_4", password: "abc123ab")
user5 = User.create!(user_name: "tester_5", password: "abc123ab")
user6 = User.create!(user_name: "tester_6", password: "abc123ab")
user7 = User.create!(user_name: "tester_7", password: "abc123ab")
user8 = User.create!(user_name: "tester_8", password: "abc123ab")
user9 = User.create!(user_name: "tester_9", password: "abc123ab")

# Questions

question1 = Question.create!(title: "test question 1", description: Faker::Lorem.paragraphs, user_id: 1)
question2 = Question.create!(title: "test question 2", description: Faker::Lorem.paragraphs, user_id: 1)
question3 = Question.create!(title: "test question 3", description: Faker::Lorem.paragraphs, user_id: 2)
question4 = Question.create!(title: "test question 4", description: Faker::Lorem.paragraphs, user_id: 2)
question5 = Question.create!(title: "test question 5", description: Faker::Lorem.paragraphs, user_id: 3)
question6 = Question.create!(title: "test question 6", description: Faker::Lorem.paragraphs, user_id: 3)

# Answers

answer1 = Answer.create!(description: Faker::Lorem.paragraphs, user_id: 2, question_id: 1, best_answer: 1)
answer2 = Answer.create!(description: Faker::Lorem.paragraph, user_id: 3, question_id: 1)
answer3 = Answer.create!(description: Faker::Lorem.paragraphs, user_id: 2, question_id: 2)
answer4 = Answer.create!(description: Faker::Lorem.paragraph, user_id: 3, question_id: 2)
answer5 = Answer.create!(description: Faker::Lorem.paragraphs, user_id: 1, question_id: 3)
answer6 = Answer.create!(description: Faker::Lorem.paragraph, user_id: 3, question_id: 3)
answer7 = Answer.create!(description: Faker::Lorem.paragraphs, user_id: 1, question_id: 4)
answer8 = Answer.create!(description: Faker::Lorem.paragraph, user_id: 2, question_id: 5)
answer9 = Answer.create!(description: Faker::Lorem.paragraphs, user_id: 2, question_id: 6)

# Comments

comment1 = Comment.create!(description: "comment for question", user_id: 2, content: question1)
comment1 = Comment.create!(description: "comment for answer", user_id: 2, content: answer1)

# Votes

vote1 = Vote.create!(value: 1, user_id: 2, target: question2)
vote2 = Vote.create!(value: 1, user_id: 3, target: answer1)
vote3 = Vote.create!(value: 1, user_id: 1, target: comment1)
vote4 = Vote.create!(value: -1, user_id: 4, target: question1)
vote5 = Vote.create!(value: 1, user_id: 2, target: question1)
vote6 = Vote.create!(value: 1, user_id: 2, target: answer1)
vote7 = Vote.create!(value: 1, user_id: 7, target: question1)
vote8 = Vote.create!(value: 1, user_id: 8, target: question1)
vote9 = Vote.create!(value: 1, user_id: 9, target: answer1)
vote10 = Vote.create!(value: 1, user_id: 3, target: question2)
vote11 = Vote.create!(value: 1, user_id: 8, target: question3)
vote12 = Vote.create!(value: 1, user_id: 7, target: question4)
vote13 = Vote.create!(value: -1, user_id: 8, target: question6)
vote14 = Vote.create!(value: 1, user_id: 8, target: question1)






