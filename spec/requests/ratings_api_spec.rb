require 'rails_helper'

describe 'Ratings API' do
  context 'POST /api/v1/ratings' do
    it 'should create and return a store' do
      post api_v1_ratings_path, params: { rating: { value: 5, opinion: 'Great place', user_name: 'Jhon Doe' },
                                          store: { longitude: -49.269026, latitude: -25.447301, name: 'Pub X',
                                                   address: 'Av Paulista', google_place_id: '12345' } }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['value']).to eq(5)
      expect(parsed_body['opinion']).to eq('Great place')
      expect(parsed_body['user_name']).to eq('Jhon Doe')
    end

    it 'should not create a new store' do
      store = create(:store, lonlat: 'POINT(-49.269026 -25.447301)', name: 'Pub X',
                             address: 'Av Paulista', google_place_id: '12345')

      post api_v1_ratings_path, params: { rating: { value: 5, opinion: 'Great place', user_name: 'Jhon Doe' },
                                          store: { longitude: -49.269026, latitude: -25.447301, name: 'Pub X',
                                                   address: 'Av Paulista', google_place_id: '12345' } }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['store_id']).to eq(store.id)
      expect(parsed_body['value']).to eq(5)
      expect(parsed_body['opinion']).to eq('Great place')
      expect(parsed_body['user_name']).to eq('Jhon Doe')
    end

    it 'should not create a new store and rating' do
      post api_v1_ratings_path

      expect(response).to have_http_status(412)
    end
  end
end
