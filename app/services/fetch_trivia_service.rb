class FetchTriviaService
  GENERAL_KNOWLEDGE = "9".freeze
  BOOKS = "10".freeze
  FILM = "11".freeze
  MUSIC = "12".freeze
  MUSICALS_AND_THEATRE = "13".freeze
  TV = "14".freeze
  VIDEO_GAMES = "15".freeze
  BOARD_GAMES = "16".freeze
  SCIENCE_AND_NATURE = "17".freeze
  COMPUTERS = "18".freeze
  MATH = "19".freeze
  MYTHOLOGY = "20".freeze
  SPORTS = "21".freeze
  GEOGRAPHY = "22".freeze
  HISTORY = "23".freeze
  POLITICS = "24".freeze
  ART = "25".freeze
  CELEBRITIES = "26".freeze
  ANIMALS = "27".freeze
  VEHICLES = "28".freeze
  COMICS = "29".freeze
  GADGETS = "30".freeze
  ANIME_AND_MANGA = "31".freeze
  CARTOON_AND_ANIMATIONS = "32".freeze
  CATEGORIES = [
    GENERAL_KNOWLEDGE,
    BOOKS,
    FILM,
    MUSIC,
    TV,
    SCIENCE_AND_NATURE,
    COMPUTERS,
    MATH,
    MYTHOLOGY,
    SPORTS,
    GEOGRAPHY,
    HISTORY,
    POLITICS,
    ART,
    ANIMALS,
    VEHICLES,
    GADGETS,
  ].freeze
  NUMBER_OF_QUESTIONS = "1".freeze

  def self.run(category_id: CATEGORIES.sample)
    new(category_id).run
  end

  def initialize(category_id)
    @category_id = category_id
  end

  def run
    random_questions = get_random_questions
    random_questions["results"].each { |result| save_trivia_item(result) }
  end

  private

  attr_reader :category_id

  def trivia_url
    "https://opentdb.com/api.php?amount=#{NUMBER_OF_QUESTIONS}&category=#{category_id}"
  end

  def get_random_questions
    HTTParty.get(trivia_url)
  end

  def save_trivia_item(result)
    trivia_item = TriviaItem.new(
      category: parse_string(result["category"]),
      correct_answer: parse_string(result["correct_answer"]),
      difficulty: result["difficulty"],
      question_type: result["type"],
      question: parse_string(result["question"]),
    )
    trivia_item.incorrect_answers = result["incorrect_answers"].map { |answer| parse_string(answer) }
    trivia_item.save!
  end

  def parse_string(string)
    string
      .gsub(/&quot;/,'"')
      .gsub(/&#039;/,"'")
      .gsub(/&eacute;/,"é")
      .gsub(/&amp;/, "&")
      .gsub(/&Eacute;/, "É")
      .gsub(/&iacute;/, "í")
      .gsub(/&ocirc;/, "ô")
      .gsub(/&uuml;/, "ü")
      .gsub(/&egrave;/, "è")
      .gsub(/&rsquo;/, "'")
      .gsub(/&uacute;/, "ú")
      .gsub(/&aacute;/, "á")
  end
end
