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

    context "when requesting google images" do
      it "returns last 9 google images created within the last 30 seconds" do
        Timecop.freeze(DateTime.current.beginning_of_day) do
          create_list(:image, 10, :google)
          new_google_image = create :image, :google
          create :image, :google, created_at: DateTime.yesterday.beginning_of_day
          create :image, :twilio

          get "/api/images?image_source=google"
          parsed_response = JSON.parse(response.body)

          expect(parsed_response.length).to eq 9
          parsed_response.last.tap do |elem|
            expect(elem["id"]).to eq(new_google_image.id)
            expect(elem["url"]).to eq(new_google_image.url)
            expect(elem["from_number"]).to eq(new_google_image.from_number)
            expect(elem["image_source"]).to eq(new_google_image.image_source)
          end
        end
      end
    end

    context "when requesting twilio images" do
      it "returns all twilio images" do
        twilio_image = create :image, :twilio
        create :image, :google

        get "/api/images?image_source=twilio"
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        parsed_response.first.tap do |elem|
          expect(elem["id"]).to eq(twilio_image.id)
          expect(elem["url"]).to eq(twilio_image.url)
          expect(elem["from_number"]).to eq(twilio_image.from_number)
          expect(elem["caption"]).to eq(twilio_image.caption)
          expect(elem["image_source"]).to eq(twilio_image.image_source)
        end
      end
    end
  end
end
