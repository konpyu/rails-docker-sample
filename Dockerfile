FROM ruby:2.2.1

RUN apt-get update && apt-get install -y nodejs mysql-client --no-install-recommends

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/
RUN bundle install -j4 --without development test

COPY . /app

EXPOSE 3000
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]
