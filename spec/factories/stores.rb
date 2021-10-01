FactoryBot.define do
  factory :store do
    sequence(:name) { |n| "name#{n}" }
    address { 'Champ de Mars, 5 Av. Anatole France, 75007 Paris, France' }
    sequence(:google_place_id) { |n| n }
    lonlat { "POINT(#{-49.269027} #{-25.447306})" }
  end
end