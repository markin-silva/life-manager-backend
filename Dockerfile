FROM ruby:3.3.0

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN chmod +x entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
