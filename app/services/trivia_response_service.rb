class TriviaResponseService
  def self.handle_response(guess)
    new(guess).handle_response
  end

  def initialize(guess)
    @guess = guess
  end

  def handle_response
    save_guess
    update_trivia_item
    get_new_trivia_item
  end

  private

  attr_reader :guess

  def save_guess
    current_trivia_item.update!(guess: modified_guess)
  end

  def update_trivia_item
    if correct_guess?
      current_trivia_item.correct!
    else
      current_trivia_item.incorrect!
    end
  end

  def get_new_trivia_item
    FetchTriviaService.run
  end

  def correct_guess?
    modified_guess.downcase == current_trivia_item.correct_response.downcase
  end

  def modified_guess
    if sounds_like_b?
      "b"
    else
      guess
    end
  end

  def sounds_like_b?
    [
      "be",
      "beat",
      "bee",
      "beet",
    ].include?(guess)
  end

  def current_trivia_item
    TriviaItem.unanswered.order("id desc").last
  end
end
