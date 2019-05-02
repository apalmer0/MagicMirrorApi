class FetchTriviaService
  def self.run
    new().run
  end

  def run
    random_questions = get_random_questions
    random_questions.each { |question| save_question(question) }
  end

  private

  def get_random_questions
    HTTParty.get("http://jservice.io/api/random")
  end

  def save_question(trivia)
    TriviaItem.create(
      answer: trivia.dig("answer"),
      category: trivia.dig("category", "title"),
      question: trivia.dig("question"),
      value: trivia.dig("value"),
    )
  end
end
