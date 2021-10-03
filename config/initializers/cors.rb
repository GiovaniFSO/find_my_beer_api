Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['URL_WEB_APP']

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
