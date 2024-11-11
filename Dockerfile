FROM ruby:3.3.1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV RAILS_ENV=development

CMD ["bundle", "exec", "./bin/rails", "server", "-b", "0.0.0.0", "-p", "7777"]