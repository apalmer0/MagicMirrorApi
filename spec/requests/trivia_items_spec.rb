require 'rails_helper'

describe "TriviaItems API", type: :request do
  describe "GET /trivia_items" do
    context "when requesting all items" do
      it "returns all items" do
        trivia_item_1 = create(:trivia_item, question: "question 1", answer: "answer 1")
        trivia_item_2 = create(:trivia_item, question: "question 2", answer: "answer 2")

        get "/api/trivia_items"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 2
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(trivia_item_1.id)
          expect(elem["question"]).to eq(trivia_item_1.question)
          expect(elem["answer"]).to eq(trivia_item_1.answer)
          expect(elem["category"]).to eq(trivia_item_1.category)
          expect(elem["status"]).to eq(trivia_item_1.status)
        end
        parsed_response.last.tap do |elem|
          expect(elem["id"]).to eq(trivia_item_2.id)
          expect(elem["question"]).to eq(trivia_item_2.question)
          expect(elem["answer"]).to eq(trivia_item_2.answer)
          expect(elem["category"]).to eq(trivia_item_2.category)
          expect(elem["status"]).to eq(trivia_item_2.status)
        end
      end
    end

    context "when requesting unanswered trivia items" do
      it "returns all unanswered trivia items" do
        trivia_item_1 = create(:trivia_item, :unanswered, question: "question 1", answer: "answer 1")
        trivia_item_2 = create(:trivia_item, :correct, question: "question 2", answer: "answer 2")

        get "/api/trivia_items?status=unanswered"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(trivia_item_1.id)
          expect(elem["question"]).to eq(trivia_item_1.question)
          expect(elem["answer"]).to eq(trivia_item_1.answer)
          expect(elem["category"]).to eq(trivia_item_1.category)
          expect(elem["status"]).to eq(trivia_item_1.status)
        end
      end
    end

    context "when requesting a limited number of trivia items" do
      it "returns a limited number of trivia items" do
        trivia_item_1 = create(:trivia_item, question: "question 1", answer: "answer 1")
        trivia_item_2 = create(:trivia_item, question: "question 2", answer: "answer 2")

        get "/api/trivia_items?limit=1"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(trivia_item_2.id)
          expect(elem["question"]).to eq(trivia_item_2.question)
          expect(elem["answer"]).to eq(trivia_item_2.answer)
          expect(elem["category"]).to eq(trivia_item_2.category)
          expect(elem["status"]).to eq(trivia_item_2.status)
        end
      end
    end
  end
end
