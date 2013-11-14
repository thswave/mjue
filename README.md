## What you need

  - [RVM](http://rvm.io) (Optional, but recommended)
  - [Elasticsearch](http://www.elasticsearch.org/)

## Setup

  1. Install required gems with Bundler

  2. Create and migrate database

        $ bundle exec rake db:migrate

## Start Susugang

  1. Start Elasticsearch process

        $ cd (directory where Elasticsearch is installed)
        $ bin/elasticsearch

  2. Start server

        $ rails server
