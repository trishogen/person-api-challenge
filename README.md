# person-api-challenge
Coding challenge for a person API

## Setup Instructions for Running Locally

### MacOS

#### Postgres
This demo uses postgres for its database, if you don't already have it installed
you can use [homebrew](https://wiki.postgresql.org/wiki/Homebrew) to install it and start it up:

```
$ brew install postgresql
$ brew services start postgresql
$ psql postgres
```

#### Ruby on Rails

Use [RVM](https://rvm.io/) manager to install the latest version of Ruby and Rails.
If you don't want to use RVM you can follow one of the suggestions in the
[ruby docs](https://www.ruby-lang.org/en/documentation/installation/) or the
[rails docs](https://guides.rubyonrails.org/v5.0/getting_started.html)
```
$ gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
$ \curl -sSL https://get.rvm.io | bash -s stable --rails
```
To make sure RVM is fully ready to go: close out your current shell or terminal
session and open a new one (preferred). You may load RVM with the following command:
```
$ source ~/.rvm/scripts/rvm
```

Run updates and install bundler (package manager):
```
$ gem update --system
$ gem install bundler
```

Clone the repository, from the root of the project run bundler to install dependencies:
```
$ cd person-api-challenge
$ bundle install
```

#### Create database and run migrations

```
$ rake db:create
$ rake db:migrate
```

#### Starting server
```
$ rails s
```

## Running tests
To run tests use rspec from the root of the project
```
$ rspec
```

## API routes

| HTTP VERB   | URL                              | Result                                      |
| ----------- | -------------------------------- | ------------------------------------------- |
| GET         | /people                          | Returns all people                          |
| POST        | /people                          | Create new person                           |
| GET         | /people/:id                      | Get a person by their ID                    |
| PUT         | /people/:id                      | Update a person                             |
| DELETE      | /people/:id                      | Delete a person                             |
| GET         | /people/:person_id/versions/:id  | Get a person by their ID and version number |

### Note on Versioning
I chose to implement versioning so that the version ID given to the last route above
goes in chronological order per person. So person 1 could have a version 1,2,3...
and so can person 2. I thought that this would make it easier for the purpose of
this demo but of course this could have been implemented differently.

Deletions are written to the `versions` table but excluded from the count above.
Creations, including re-creations are included in the count.

For example:

Legolas gets created => Legolas version 1
Legolas changes his email => Legolas version 2
Legolas gets deleted => Written to the `versions` table but a get request for version 3 would return not found
Legolas gets recreated from version 2 => Legolas version 3

## Improvements
Here are some improvements I would make if I had used ~6 hours instead of 5
* Expand the test suite! (especially controller tests), I've stubbed some of these out
* API and version name spacing ( forgot to do this at the beginning... :( )
* Clear out more of the boiler plate code/files
* Remove timestamps from Person object/db, they became redundant when I implemented versioning
* More thorough installation process (i.e. other operating systems or some other installation solution)
