FROM ruby:2.5.1
#ENV LANG C.UTF-8
ENV APP_HOME /app

# debconf: delaying package configuration, since apt-utils is not installed
# ENV DEBCONF_NOWARNINGS yes

# 必要なものをインストール
RUN apt-get update
RUN apt-get install -y nodejs mysql-client --no-install-recommends

RUN gem install bundler

WORKDIR $APP_HOME
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD . $APP_HOME
