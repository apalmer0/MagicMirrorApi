require "rails_helper"

describe GoogleImagesService do
  describe ".fetch_images" do
    search_results = JSON.parse(
      File.read("spec/fixtures/google_images/image_search_results.rb")
    )
    search_term = "dogs"

    before { allow(HTTParty).to receive(:get).and_return(search_results) }

    it "hits the Google search api" do
      GoogleImagesService.fetch_images(search_term)
      expect(HTTParty).to have_received(:get).with(
        "https://www.googleapis.com/customsearch/v1?key=#{ENV["GOOGLE_API_KEY"]}&cx=#{ENV["CUSTOM_SEARCH_ENGINE_ID"]}&q=#{search_term}&searchType=image&num=9&fileType=jpg&imgSize=xlarge&alt=json",
      )
    end

    it "creates images for each item in the response" do
      expect(Image.count).to eq 0

      GoogleImagesService.fetch_images(search_term)

      expect(Image.count).to eq 10
      Image.first.tap do |image|
        expect(image.image_source).to eq "google"
        expect(image.query).to eq search_term
        expect(image.url).to eq "https://dynaimage.cdn.cnn.com/cnn/q_auto,w_1024,c_fill,g_auto,h_576,ar_16:9/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F180316113418-travel-with-a-dog-3.jpg"
      end
    end
  end
end
