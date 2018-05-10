if Rails.env.development?
  image_content = [
    {
      url: "https://cdn.britannica.com/700x450/24/71324-120-CA22C4BA.jpg",
      caption: "walking on the moon",
      from_number: "+15555555555",
    },
    {
      url: "http://www.nasa.gov/sites/default/files/thumbnails/image/s69-39961.jpg",
      caption: "blastoff",
      from_number: "+15555555555",
    },
    {
      url: "http://www.meteoweb.eu/wp-content/uploads/2013/04/Terra-luna.jpg",
      caption: "earthrise",
      from_number: "+15555555555",
    },
    {
      url: "https://3c1703fe8d.site.internapcdn.net/newman/gfx/news/hires/2017/5-marscuriosit.jpg",
      caption: "chilling on mars",
      from_number: "+15555555555",
    },
    {
      url: "http://www.nasa.gov/sites/default/files/pia17936_evening_star.jpg",
      caption: "that star is the earth. this was taken from mars",
      from_number: "+15555555555",
    },
    {
      url: "http://www.esa.int/var/esa/storage/images/esa_multimedia/images/2016/09/comet_from_16_km/16159854-1-eng-GB/Comet_from_16_km.jpg",
      caption: "chilling on a comet",
      from_number: "+15555555555",
    }
  ]

  image_content.each do |content|
    i = Image.create!(
      caption: content[:caption],
      from_number: content[:from_number],
      url: content[:url],
    )
    puts "created image #{i.id}"
  end
end
