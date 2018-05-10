require 'rails_helper'

describe "Items API", type: :request do
  describe "GET /images" do
    context "when requesting all images" do
      it "returns all images" do
        image_1 = create :image
        image_2 = create :image

        get "/api/images"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 2
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(image_1.id)
          expect(elem["url"]).to eq(image_1.url)
          expect(elem["from_number"]).to eq(image_1.from_number)
          expect(elem["caption"]).to eq(image_1.caption)
        end
        parsed_response.last.tap do |elem|
          expect(elem["id"]).to eq(image_2.id)
          expect(elem["url"]).to eq(image_2.url)
          expect(elem["from_number"]).to eq(image_2.from_number)
          expect(elem["caption"]).to eq(image_2.caption)
        end
      end
    end
  end
end
