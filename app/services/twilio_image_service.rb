class TwilioImageService
  def initialize(params)
    @url = params["MediaUrl0"]
    @from_number = params["From"]
    @body = params["Body"]
  end

  def self.create_image!(params)
    new(params).create_image!
  end

  def create_image!
    if @url.present?
      Image.create!(
        caption: @body,
        from_number: @from_number,
        image_source: "twilio",
        url: @url,
      )
    end
  end
end
