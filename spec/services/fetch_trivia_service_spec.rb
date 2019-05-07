require "rails_helper"

describe FetchTriviaService do
  describe ".run" do
    let(:response) do
      {
        "response_code" => 0,
        "results" => [
          {
            "category" => "Entertainment: Video Games",
            "type" => "boolean",
            "difficulty" => "hard",
            "question" => "In &quot;Portal 2&quot;, Cave Johnson started out Aperture Science as a shower curtain company.",
            "correct_answer" => "True",
            "incorrect_answers" => [
              "False"
            ]
          }
        ]
      }
    end
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    it "makes a get request to Open Trivia DB" do
      FetchTriviaService.run(category_id: 2)

      expect(HTTParty).to have_received(:get).with("https://opentdb.com/api.php?amount=1&category=2")
    end

    it "creates a TriviaItem for each item returned" do
      expect { FetchTriviaService.run }
        .to change { TriviaItem.count }
        .from(0).to(1)
    end

    it "saves the correct attributes on the TriviaItem for each item returned" do
      FetchTriviaService.run

      expect(TriviaItem.last).to have_attributes(
        category: "Entertainment: Video Games",
        correct_answer: "True",
        difficulty: "hard",
        guess: nil,
        incorrect_answers: ["False"],
        question: "In \"Portal 2\", Cave Johnson started out Aperture Science as a shower curtain company.",
        question_type: "boolean",
        status: "unanswered",
      )
    end
  end
end
