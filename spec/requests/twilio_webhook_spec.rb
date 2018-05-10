require 'rails_helper'

describe "Twilio Webhook", type: :request do
  before do
    allow(TwilioImageService).to receive(:create_image!).and_call_original
  end

  it "calls the TwilioImageService" do
    image_params = JSON.parse(
      File.read("spec/fixtures/twilio_events/image_message.rb")
    )

    post "/twilio_webhook", params: image_params

    expect(TwilioImageService).to have_received(:create_image!)
    expect(response).to have_http_status :ok
  end
end
