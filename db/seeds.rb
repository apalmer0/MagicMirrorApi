if Rails.env.development?
  def to_unix(time)
    time.strftime("%s")
  end

  puts "Clearing out existing data..."
  Item.destroy_all
  ForecastItem.destroy_all
  TriviaItem.destroy_all
  puts "Done."

  today = DateTime.current
  tomorrow = today + 1.day
  yesterday = today - 1.day
  due_today = today.strftime("%Y-%m-%d")
  due_tomorrow = tomorrow.strftime("%Y-%m-%d")
  due_yesterday = yesterday.strftime("%Y-%m-%d")

  items = [
    { todoist_id: "51", due: due_today, status: "incomplete", user_id: "1", content: "Cancel nord vpn" },
    { todoist_id: "52", due: due_today, status: "incomplete", user_id: "1", content: "Fix mirror api" },
    { todoist_id: "53", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Call 888-DIG-SAFE" },
    { todoist_id: "54", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Move cornhole boards" },
    { todoist_id: "55", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Update actual mirror" },
    { todoist_id: "56", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Place prana order" },
    { todoist_id: "57", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Do laundry" },
    { todoist_id: "58", due: due_tomorrow, status: "incomplete", user_id: "1", content: "wash towels" },
    { todoist_id: "59", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Wash prana clothes" },
    { todoist_id: "10", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Tie back bookshelf" },
    { todoist_id: "11", due: due_tomorrow, status: "incomplete", user_id: "1", content: "mail letter" },
    { todoist_id: "12", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Fix doorknob" },
    { todoist_id: "13", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Assemble box" },
    { todoist_id: "14", due: due_tomorrow, status: "incomplete", user_id: "1", content: "put away recycling" },
    { todoist_id: "15", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Make rice" },
    { todoist_id: "16", due: due_tomorrow, status: "incomplete", user_id: "1", content: "take out trash" },
    { todoist_id: "17", due: due_tomorrow, status: "incomplete", user_id: "1", content: "vacuum" },
    { todoist_id: "18", due: due_tomorrow, status: "incomplete", user_id: "1", content: "pick up poop" },
    { todoist_id: "19", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Buy storage bin" },
    { todoist_id: "20", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Fix mirror" },
    { todoist_id: "21", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Pay bill" },
    { todoist_id: "22", due: due_tomorrow, status: "incomplete", user_id: "1", content: "test" },
    { todoist_id: "23", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Unload dishwasher" },
    { todoist_id: "24", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Test" },
    { todoist_id: "25", due: due_tomorrow, status: "incomplete", user_id: "1", content: "haircut" },
    { todoist_id: "26", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Make reservation" },
    { todoist_id: "27", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Get saw" },
    { todoist_id: "28", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Take out trash" },
    { todoist_id: "29", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Fix shelves" },
    { todoist_id: "30", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Secure windows" },
    { todoist_id: "31", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Cut watermelon" },
    { todoist_id: "32", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Climb" },
    { todoist_id: "33", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Make lunches" },
    { todoist_id: "34", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Unload dishwasher" },
    { todoist_id: "35", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Mail r2" },
    { todoist_id: "36", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Tape up box" },
    { todoist_id: "37", due: due_tomorrow, status: "incomplete", user_id: "1", content: "unload dishwasher" },
    { todoist_id: "38", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Put away chairs and table" },
    { todoist_id: "39", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Buy window laminate" },
    { todoist_id: "40", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Put covers on chair cushions" },
    { todoist_id: "41", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Plunge toilet" },
    { todoist_id: "42", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Finish updating mirror" },
    { todoist_id: "43", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Unload dishwasher" },
    { todoist_id: "44", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Buy rug" },
    { todoist_id: "45", due: due_tomorrow, status: "incomplete", user_id: "1", content: "Take out trash and compost" },
    { todoist_id: "46", due: due_tomorrow, status: "incomplete", user_id: "1", content: "make bed" },
    { todoist_id: "47", due: due_tomorrow, status: "incomplete", user_id: "1", content: "do dishes" },
    { todoist_id: "48", due: due_yesterday, status: "incomplete", user_id: "1", content: "Replace stove light" },
    { todoist_id: "49", due: due_yesterday, status: "incomplete", user_id: "1", content: "Do bed laundry" },
    { todoist_id: "50", due: due_yesterday, status: "incomplete", user_id: "1", content: "Laminate windows" },
  ]
  forecast_items = [
    { unix_time: to_unix(today.beginning_of_day + 1.hour), temperature: 62, precip_chance: 55 },
    { unix_time: to_unix(today.beginning_of_day + 4.hours), temperature: 62, precip_chance: 15 },
    { unix_time: to_unix(today.beginning_of_day + 7.hours), temperature: 59, precip_chance: 15 },
    { unix_time: to_unix(today.beginning_of_day + 10.hours), temperature: 57, precip_chance: 40 },
    { unix_time: to_unix(today.beginning_of_day + 13.hours), temperature: 54, precip_chance: 45 },
    { unix_time: to_unix(today.beginning_of_day + 16.hours), temperature: 49, precip_chance: 0 },
    { unix_time: to_unix(today.beginning_of_day + 19.hours), temperature: 46, precip_chance: 0 },
    { unix_time: to_unix(today.beginning_of_day + 22.hours), temperature: 43, precip_chance: 0 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 1.hour), temperature: -40, precip_chance: 0 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 4.hours), temperature: -39, precip_chance: 0 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 7.hours), temperature: 8, precip_chance: 5 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 10.hours), temperature: 21, precip_chance: 0 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 13.hours), temperature: 43, precip_chance: 0 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 16.hours), temperature: 31, precip_chance: 90 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 19.hours), temperature: 60, precip_chance: 0 },
    { unix_time: to_unix(tomorrow.beginning_of_day + 22.hours), temperature: 39, precip_chance: 0 },
  ]
  trivia_items = [
    { question: "In Topology, the complement of an open set is a closed set.", correct_answer: "True", status: "incorrect", category: "Science: Mathematics", created_at: "2019-05-07 02:28:23", updated_at: "2019-07-15 12:59:14", guess: "D", incorrect_answers: ["False"], difficulty: "hard", question_type: "boolean", correct_letter: nil },
    { question: "Danganronpa 2: Goodbye Despair featured all of the surviving students from the first game.", correct_answer: "True", status: "incorrect", category: "Entertainment: Video Games", created_at: "2019-05-07 02:39:32", updated_at: "2019-07-15 12:59:14", guess: "D", incorrect_answers: ["False"], difficulty: "easy", question_type: "boolean", correct_letter: nil },
    { question: "A 'Millinillion' is a real number.", correct_answer: "True", status: "incorrect", category: "Science: Mathematics", created_at: "2019-05-07 11:14:35", updated_at: "2019-07-15 12:59:14", guess: "D", incorrect_answers: ["False"], difficulty: "medium", question_type: "boolean", correct_letter: nil },
    { question: "Pablo Picasso is one of the founding fathers of \"Cubism.\"", correct_answer: "True", status: "correct", category: "Art", created_at: "2020-05-24 23:46:10", updated_at: "2020-05-28 02:15:22", guess: "true", incorrect_answers: ["False"], difficulty: "medium", question_type: "boolean", correct_letter: nil },
    { question: "What was William Frederick Cody better known as?", correct_answer: "Buffalo Bill", status: "correct", category: "History", guess: "a", incorrect_answers: ["Billy the Kid", "Wild Bill Hickok", "Pawnee Bill"], difficulty: "easy", question_type: "multiple", correct_letter: "A" },
    { question: "What is Hermione Granger's middle name?", correct_answer: "Jean", status: "correct", category: "Entertainment: Books", guess: "a", incorrect_answers: ["Jane", "Emma", "Jo"], difficulty: "hard", question_type: "multiple", correct_letter: "A" },
    { question: "What is the relationship between the band members of American rock band King of Leon?", correct_answer: "Brothers &amp; cousins", status: "correct", category: "Entertainment: Music", guess: "C", incorrect_answers: ["Childhood friends", "Former classmates", "Fraternity house members"], difficulty: "medium", question_type: "multiple", correct_letter: "C" },
    { question: "Which of the following countries is within the Eurozone but outside of the Schengen Area?", correct_answer: "Cyprus", status: "correct", category: "Geography", guess: "C", incorrect_answers: ["Malta", "Greece", "Portugal"], difficulty: "medium", question_type: "multiple", correct_letter: "C" },
    { question: "In the game Call of Duty, what is the last level where you play as an American soldier?", correct_answer: "Festung Recogne", status: "correct", category: "Entertainment: Video Games", guess: "D", incorrect_answers: ["Ste. Mere-Eglise (Day)", "Chateau", "Brecourt"], difficulty: "hard", question_type: "multiple", correct_letter: "D" },
    { question: "The 'Squaring the Circle' problem is solvable.", correct_answer: "False", status: "incorrect", category: "Science: Mathematics", created_at: "2020-05-28 02:15:23", updated_at: "2020-05-31 03:09:53", guess: "true", incorrect_answers: ["True"], difficulty: "easy", question_type: "boolean", correct_letter: nil },
  ]

  puts "Creating Todo items..."
  items.each { |item| Item.create(item) }
  puts "Done."
  puts "Creating Forecast items..."
  forecast_items.each { |item| ForecastItem.create(item) }
  puts "Done."
  puts "Creating Trivia items..."
  trivia_items.each { |item| TriviaItem.create(item) }
  puts "Done."
end
