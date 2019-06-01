FROM ruby:2.5
WORKDIR /workdir
RUN gem install jekyll
COPY . .
RUN jekyll build
