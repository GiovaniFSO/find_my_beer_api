def mock_google_stores_within(latitude:, longitude:, radius: 5000)
  location = "&location=#{latitude},#{longitude}"
  range = "&radius=#{radius}"
  base_url = "#{Rails.configuration.google_urls[:all_stores]}#{location}#{range}"

  google_stores_all = File.read(Rails.root.join('spec/fixtures/google_stores_all.json'))

  allow(Faraday).to receive(:get)
    .with(base_url).and_return(instance_double(Faraday::Response, status: 200, body: google_stores_all))
end

def mock_find_google_store(place_id)
  base_url = "#{Rails.configuration.google_urls[:find_store]}&place_id=#{place_id}"

  google_store_find = File.read(Rails.root.join('spec/fixtures/google_store_find.json'))

  allow(Faraday).to receive(:get)
    .with(base_url).and_return(instance_double(Faraday::Response, status: 200, body: google_store_find))
end

def mock_wrong_place_id(place_id)
  base_url = "#{Rails.configuration.google_urls[:find_store]}&place_id=#{place_id}"

  google_store_invalid = File.read(Rails.root.join('spec/fixtures/google_store_invalid.json'))

  allow(Faraday).to receive(:get)
    .with(base_url).and_return(instance_double(Faraday::Response, status: 200, body: google_store_invalid))
end
