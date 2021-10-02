FactoryBot.define do
  factory :google_store do
    trait :pub do
      latitude { 53.3458948 }
      longitude { -6.2596063 }
      place_id { 'ChIJY8EByoQOZ0gRSMYJds1CQHU' }
    end

    trait :desert do
      latitude { -23.863967 }
      longitude { -69.211946 }
    end
  end
end
