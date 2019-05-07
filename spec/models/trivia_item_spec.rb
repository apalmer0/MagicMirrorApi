require "rails_helper"

RSpec.describe TriviaItem, type: :model do
  describe "validations" do
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:correct_answer) }
    it { should validate_presence_of(:difficulty) }
    it { should validate_presence_of(:incorrect_answers) }
    it { should validate_presence_of(:question_type) }
    it { should validate_presence_of(:question) }
    it { should define_enum_for(:status).with_values([:unanswered, :incorrect, :correct]) }
  end

  describe "letters_and_answers" do
    let(:item) do
      build(
        :trivia_item,
        correct_answer: "1",
        incorrect_answers: ["2", "3", "4"],
        correct_letter: "C",
      )
    end

    it "returns a hash of letter keys and answer values" do
      expect(item.letters_and_answers).to eq(
        {
          "A" => "2",
          "B" => "3",
          "C" => "1",
          "D" => "4"
        }
      )
    end
  end

  describe "correct_response" do
    context "with a multiple choice question" do
      it "returns the correct letter" do
        item = TriviaItem.new(question_type: "multiple", correct_letter: "A")

        expect(item.correct_response).to eq("A")
      end
    end

    context "with a true/false question" do
      it "returns the correct response" do
        item = TriviaItem.new(question_type: "boolean", correct_letter: nil, correct_answer: "True")

        expect(item.correct_response).to eq("True")
      end
    end
  end

  describe "set_defaults" do
    it "is created as 'unanswered'" do
      item = TriviaItem.new

      expect(item).to be_unanswered
    end

    context "with a multiple choice question" do
      it "sets a correct answer letter" do
        item = TriviaItem.new(question_type: "multiple")

        expect(item.correct_letter).not_to be_nil
      end
    end

    context "with a true/false question" do
      it "does not set a correct answer letter" do
        item = TriviaItem.new(question_type: "boolean")

        expect(item.correct_letter).to be_nil
      end
    end
  end
end
