require "rails_helper"

describe FetchTriviaService do
  describe ".run" do
    let(:response) do
      [
        {
          "id" => 9146,
          "answer" => "yellow",
          "question" => "Since this was the color of Elizabeth's gown, guests were asked not to wear it",
          "value" => 100,
          "airdate" => "1992-05-20T12:00:00.000Z",
          "created_at" => "2014-02-11T22:52:00.943Z",
          "updated_at" => "2014-02-11T22:52:00.943Z",
          "category_id" => 1091,
          "game_id" => nil,
          "invalid_count" => nil,
          "category" => {
            "id" => 1091,
            "title" => "elizabeth taylor's wedding",
            "created_at" => "2014-02-11T22:52:00.873Z",
            "updated_at" => "2014-02-11T22:52:00.873Z",
            "clues_count" => 5
          }
        }
      ]
    end
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    it "makes a get request to jService" do
      FetchTriviaService.run

      expect(HTTParty).to have_received(:get).with("http://jservice.io/api/random")
    end

    it "creates a TriviaItem for each item returned" do
      expect(TriviaItem.count).to eq 0

      FetchTriviaService.run

      expect(TriviaItem.count).to eq 1
    end
  end
end
