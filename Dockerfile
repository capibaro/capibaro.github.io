FROM ruby:2.7
RUN bundle config --global frozen 1
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
WORKDIR /blog
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . /blog/