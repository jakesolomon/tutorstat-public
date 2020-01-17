# README

Tutorstat is built with Ruby 2.6.4p104 (2019-08-28 revision 67798) [x86_64-darwin18] and Rails 5.2.3 database is built using PostgreSQL 11.

To install dependencies, run:

yarn install

To initialize database, run:

rake db:create

rake db:migrate

rake db:seed


Javascript dependencies are managed using Yarn (I'm using version 1.17.3), static assets are created with Webpacker 3.3, javascript is compiled using Babel 5.8.35.

To compile assets, run:

yarn run start

To boot localhost server with Puma 3.12, run:

bundle exec rails s

# tutorstat
