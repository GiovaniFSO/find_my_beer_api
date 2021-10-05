# Find My Beer API  <img align="center" alt="Giovani-Ruby" height="30" width="40" src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-plain.svg">
https://find-my-beer-web-giovanifso.vercel.app/

Accept to share location to find pubs close to you or if you deny i'll set Dublin location, so you can test it :D
## Requirements
- Docker

## Getting started
To run in localhost you'll need to create an Google Api Key and enable Places API and Maps JavaScript API at https://console.cloud.google.com/google/maps-apis/credentials and create a .env with the keys GOOGLE_KEY and URL_WEB_APP(front_url - https://github.com/GiovaniFSO/find_my_beer_web)

## Docker Compose

To run in localhost you can up it with a Docker container.

```sh
cd find_my_beer_api
docker-compose run --rm --service-ports web bash
```

Once done, you'll be able to run rails/ruby commands. To this case we gonna run at port 3001 since our front-end by default is using the port 3000
You can check test

```sh
bin/setup
rails s -p 3001 -b 0.0.0.0
```

> Note: `-b 0.0.0.0` to open access to front-end.

## Test
To run the app tests and check if everything is working as expected:
```sh
bundle exec rspec
```

## Style Guides

You can verify if the code complies with the project's standards by running robocop and correcting any highlighted alerts:
```sh
bundle exec rubocop
```
