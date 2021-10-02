require 'rails_helper'

describe 'Google Stores API' do
  context 'GET /api/v1/google_stores' do
    it 'should return all google stores' do
      google_store = attributes_for(:google_store, :pub)
      mock_google_stores_within(latitude: google_store[:latitude], longitude: google_store[:longitude])

      get '/api/v1/google_stores', params: google_store

      palace_bar_address = { 'formatted_address' => '21 Fleet St, Temple Bar, Dublin 2, D02 H950, Ireland' }
      bath_pub_address = { 'formatted_address' => '26 Bath Ave, Dublin 4, D04 X7P8, Ireland' }
      expect(response).to have_http_status(200)
      expect(parsed_body['results']).to include(include('name' => 'The Palace Bar'))
      expect(parsed_body['results']).to include(include(palace_bar_address))
      expect(parsed_body['results']).to include(include('name' => 'The Bath Pub'))
      expect(parsed_body['results']).to include(include(bath_pub_address))
    end

    xit 'should not find any google store' do
      google_store = attributes_for(:google_store, :desert)

      get '/api/v1/google_stores', params: google_store

      # TODO: not find any pub
    end
  end

  context 'GET /api/v1/google_stores' do
    it 'should return a google store' do
      google_store = attributes_for(:google_store, :pub)
      mock_find_google_store(google_store[:place_id])

      get "/api/v1/google_stores/#{google_store[:place_id]}"

      formatted_address = { 'formatted_address' => '21 Fleet St, Temple Bar, Dublin 2, D02 H950, Ireland' }
      expect(response).to have_http_status(200)
      expect(parsed_body['result']).to include('name' => 'The Palace Bar')
      expect(parsed_body['result']).to include(formatted_address)
    end

    it 'should not find any google store' do
      mock_wrong_place_id('randomthingwrong')

      get '/api/v1/google_stores/randomthingwrong'

      expect(response).to have_http_status(200)
      expect(parsed_body['status']).to eq('INVALID_REQUEST')
    end
  end
end
