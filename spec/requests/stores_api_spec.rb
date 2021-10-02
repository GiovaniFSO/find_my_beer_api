require 'rails_helper'

describe 'Stores API' do
  context 'GET /api/v1/stores' do
    it 'should get stores' do
      good_store = create(:store, name: 'Temple Bar', lonlat: 'POINT(-6.267459 53.344956)',
                                  google_place_id: 'abcd123',
                                  address: 'Essex St E, Dublin - Ireland')
      bad_store = create(:store, name: 'Fake Bar', lonlat: 'POINT(-6.237459 53.343256)',
                                 google_place_id: 'asdf123',
                                 address: 'Essex St E, Dublin - Ireland')
      create(:rating, value: 4, opinion: 'Pretty good', user_name: 'Jhon Doe', store: good_store)
      create(:rating, value: 5, opinion: 'Amazing', user_name: 'Giovani', store: good_store)
      create(:rating, value: 1, opinion: 'Terrible', user_name: 'Anonymous', store: bad_store)

      get '/api/v1/stores', params: { longitude: -6.267421, latitude: 53.344069 }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(Store.count)
      expect(parsed_body[0]['name']).to eq('Temple Bar')
      expect(parsed_body[0]['lonlat']).to eq('POINT (-6.267459 53.344956)')
      expect(parsed_body[0]['address']).to eq('Essex St E, Dublin - Ireland')
      expect(parsed_body[0]['google_place_id']).to eq('abcd123')
      expect(parsed_body[0]['ratings_average']).to eq(4)
      expect(parsed_body[0]['ratings_count']).to eq(2)
      expect(parsed_body[1]['name']).to eq('Fake Bar')
      expect(parsed_body[1]['lonlat']).to eq('POINT (-6.237459 53.343256)')
      expect(parsed_body[1]['address']).to eq('Essex St E, Dublin - Ireland')
      expect(parsed_body[1]['google_place_id']).to eq('asdf123')
      expect(parsed_body[1]['ratings_average']).to eq(1)
      expect(parsed_body[1]['ratings_count']).to eq(1)
    end

    it 'returns no stores' do
      get '/api/v1/stores'

      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/stores/:google_place_id' do
    it 'should return a store' do
      store = create(:store, name: 'Temple Bar', lonlat: 'POINT(-6.267459 53.344956)',
                             google_place_id: 'abcd123',
                             address: 'Essex St E, Dublin - Ireland')
      create(:rating, value: 4, opinion: 'Amazing', user_name: 'Giovani', store: store)
      create(:rating, value: 2, opinion: 'Good', user_name: 'Anonymous', store: store)

      get "/api/v1/stores/#{store.google_place_id}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Temple Bar')
      expect(parsed_body['lonlat']).to eq('POINT (-6.267459 53.344956)')
      expect(parsed_body['google_place_id']).to eq('abcd123')
      expect(parsed_body['address']).to eq('Essex St E, Dublin - Ireland')
      expect(parsed_body['ratings']).to include(include('user_name' => 'Giovani'))
      expect(parsed_body['ratings']).to include(include('opinion' => 'Amazing'))
      expect(parsed_body['ratings']).to include(include('value' => 4))
      expect(parsed_body['ratings']).to include(include('user_name' => 'Anonymous'))
      expect(parsed_body['ratings']).to include(include('opinion' => 'Good'))
      expect(parsed_body['ratings']).to include(include('value' => 2))
    end

    it 'should not find any store' do
      get '/api/v1/stores/ABC1234'

      expect(response).to have_http_status(404)
    end
  end
end
