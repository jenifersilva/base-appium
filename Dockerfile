FROM ruby:2.6

RUN apt-get update
RUN apt-get install wget
RUN apt-get install unzip

RUN wget https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip \
    && unzip BrowserStackLocal-linux-x64.zip \
    && chmod +x BrowserStackLocal \
    && rm BrowserStackLocal-linux-x64.zip

RUN mkdir /tests
WORKDIR /tests

COPY Gemfile /tests
COPY Gemfile.lock /tests
RUN bundle install

ENV http_proxy $HTTP_PROXY
ENV https_proxy $HTTPS_PROXY

COPY . /tests
RUN chmod +x features/support/scripts/run_tests.sh
ENTRYPOINT ["features/support/scripts/run_tests.sh"]
CMD ["echo 'to run tests please send cucumber command with docker run'"]