class FetchTriviaService
  NUMBER_OF_QUESTIONS = "1".freeze
  TRIVIA_URL = "https://opentdb.com/api.php?amount=#{NUMBER_OF_QUESTIONS}".freeze

  def self.run
    new().run
  end

  def run
    random_questions = get_random_questions
    random_questions["results"].each { |result| save_trivia_item(result) }
  end

  private

  def get_random_questions
    HTTParty.get(TRIVIA_URL)
  end

  def save_trivia_item(result)
    trivia_item = TriviaItem.new(
      category: result["category"],
      correct_answer: result["correct_answer"],
      difficulty: result["difficulty"],
      question_type: result["type"],
      question: parse_string(result["question"]),
    )
    trivia_item.incorrect_answers = result["incorrect_answers"].map { |answer| parse_string(answer) }
    trivia_item.save!
  end

  def parse_string(string)
    string.gsub(/&quot;/,'"').gsub(/&#039;/,"'")
  end
end
