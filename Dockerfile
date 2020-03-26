FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /paack
WORKDIR /paack
COPY Gemfile /paack/Gemfile
COPY Gemfile.lock /paack/Gemfile.lock
RUN gem install bundler && bundle install --jobs 4 --retry 3
COPY . /paack
