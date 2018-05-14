class GoogleImagesService
  BASE_SEARCH_URL = "https://www.googleapis.com/customsearch/v1"

  def initialize(search_term)
    @search_term = search_term
  end

  def self.fetch_images(search_term)
    new(search_term).fetch_images
  end

  def fetch_images
    image_collection.each do |image|
      Image.create!(
        query: @search_term,
        image_source: "google",
        url: image["link"],
      )
    end
  end

  def search_results
    @search_results ||= HTTParty.get(search_url)
  end

  private

  def image_collection
    search_results["items"]
  end

  def search_url
    "#{BASE_SEARCH_URL}?"\
    "key=#{ENV["GOOGLE_API_KEY"]}"\
    "&cx=#{ENV["CUSTOM_SEARCH_ENGINE_ID"]}"\
    "&q=#{@search_term}"\
    "&searchType=image"\
    "&num=9"\
    "&fileType=jpg"\
    "&imgSize=xlarge"\
    "&alt=json"
  end
end
