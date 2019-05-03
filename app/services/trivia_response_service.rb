class TriviaResponseService
  def self.handle_response(answer)
    new(answer).handle_response
  end

  def initialize(answer)
    @answer = answer
  end

  def handle_response
    update_trivia_item
    get_new_trivia_item
  end

  private

  attr_reader :answer

  def update_trivia_item
    if correct_answer?
      current_trivia_item.correct!
    else
      current_trivia_item.incorrect!
    end
  end

  def get_new_trivia_item
    FetchTriviaService.run
  end

  def correct_answer?
    current_trivia_item.answer.downcase == answer.downcase
  end

  def current_trivia_item
    TriviaItem.unanswered.order("id desc").last
  end
end
