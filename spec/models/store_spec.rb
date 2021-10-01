require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should have_many(:ratings) }
  it { should validate_presence_of(:name).with_message("can't be blank") }
  it { should validate_presence_of(:google_place_id).with_message("can't be blank") }
  it { should validate_presence_of(:lonlat).with_message("can't be blank") }

  it 'name must to be uniq' do
    create(:store, google_place_id: '123')
    store = Store.new(google_place_id: '123')

    store.valid?

    expect(store.errors[:google_place_id]).to include('has already been taken')
  end

  it "not find away the distance" do
    near_pub = create(:store, lonlat: "POINT(#{-49.269027} #{-25.447306})")
    far_away = create(:store, lonlat: "POINT(#{2.825847} #{-60.678520})")

    pubs_found = Store.within(-49.448654, -25.441950, 100)

    expect(pubs_found).to include(near_pub)
    expect(pubs_found).to_not include(far_away)
  end

  it "find within the distance" do
    near_pub = create(:store, lonlat: "POINT(#{-49.269027} #{-25.447306})")
    far_away = create(:store, lonlat: "POINT(#{2.825847} #{-60.678520})")

    pubs_found = Store.within(-49.448654, -25.441950, 10000)

    expect(pubs_found).to include(near_pub)
    expect(pubs_found).to include(far_away)
  end

  it "not find any within the distance" do
    near_pub = create(:store, lonlat: "POINT(#{-49.269027} #{-25.447306})")
    far_away = create(:store, lonlat: "POINT(#{2.825847} #{-60.678520})")

    pubs_found = Store.within(-49.448654, -25.441950, 10)

    expect(pubs_found).to_not include(near_pub)
    expect(pubs_found).to_not include(far_away)
  end

end
