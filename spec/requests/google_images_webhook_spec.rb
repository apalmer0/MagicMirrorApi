require 'rails_helper'

describe "Google Images Webhook", type: :request do
  before do
    allow(GoogleImagesService).to receive(:fetch_images).and_return(true)
  end

  it "calls the fetch_images" do
    search_term = "dogs"

    params = { query: search_term }

    post "/google_images_webhook", params: params

    expect(GoogleImagesService).to have_received(:fetch_images).with(search_term)
    expect(response).to have_http_status :ok
  end
end
