FROM ruby:2.3.1
RUN mkdir /spotipposland
WORKDIR /spotipposland
ADD . /spotipposland
RUN bundle install
