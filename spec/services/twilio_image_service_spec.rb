require "rails_helper"

describe TwilioImageService do
  describe ".create_image!" do
    text_params = JSON.parse(
      File.read("spec/fixtures/twilio_events/text_message.rb")
    )
    image_params = JSON.parse(
      File.read("spec/fixtures/twilio_events/image_message.rb")
    )

    context "when the text contains an image" do
      it "creates an image" do
        expect(Image.count).to eq 0

        TwilioImageService.create_image!(image_params)

        expect(Image.count).to eq 1
        Image.first.tap do |image|
          expect(image.caption).to eq "this is an example image"
          expect(image.from_number).to eq "+14444444444"
          expect(image.image_source).to eq "twilio"
          expect(image.url).to eq "https://example.com/image"
        end
      end
    end

    context "when the text does not contain an image" do
      it "does not create an image" do
        expect(Image.count).to eq 0

        TwilioImageService.create_image!(text_params)

        expect(Image.count).to eq 0
      end
    end
  end
end
