FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /lists-app

WORKDIR /lists-app

ADD Gemfile /lists-app/Gemfile
ADD Gemfile.lock /lists-app/Gemfile.lock
RUN gem update --system
RUN gem install bundler
RUN bundler update --bundler
RUN bundle install
ADD . /lists-app