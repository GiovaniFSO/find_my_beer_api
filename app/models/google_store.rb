class GoogleStore
  include ActiveModel::Model
  attr_accessor :latitude, :longitude, :place_id

  def self.all(latitude:, longitude:, radius: 5000)
    location = "&location=#{latitude},#{longitude}"
    range = "&radius=#{radius}"
    base_url = "#{Rails.configuration.google_urls[:all_stores]}#{location}#{range}"
    response = Faraday.get(base_url)

    JSON.parse(response.body)
  rescue Faraday::ConnectionFailed
    []
  end

  def self.find(place_id)
    base_url = "#{Rails.configuration.google_urls[:find_store]}&place_id=#{place_id}"
    response = Faraday.get base_url

    JSON.parse(response.body)
  rescue Faraday::ConnectionFailed
    []
  end
end
