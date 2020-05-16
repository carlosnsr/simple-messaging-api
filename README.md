# Simple Messaging API

A simple messaging API done for my [Guild Education] technical test.

[Guild Education]: https://www.guildeducation.com/

## Documentation

Documentation describing this project and API is available in
[HTML](https://carlosnsr.github.io/simple-messaging-api)

In brief, the following end-points are exposed:
- to create users
  - POST `/api/v1/users`
- to create messages
  - POST `/api/v1/messages`
- to get a recipient's recent messages
  - GET `/api/v1/messages`
  - GET `/api/v1/recipents/:id/messages`
- to get a recipient's recent messages from a particular sender
  - GET `/api/v1/messages`
  - GET `/api/v1/recipents/:id/sender/:id/messages`

### Generation

Documentation is generated from the RSpec examples, using [Dox](https://github.com/infinum/dox).

To regenerate the documentation:
```
$ rails api:docs:html
```

To regenerate and view the documentation
```
$ rails api:docs:open
```

## Configuration

### Dependencies

* Ruby 2.6.5
* Rails 6.0.3

### Developer Dependencies

As above, and:

* Node v12.16.3
* Yarn v1.22.4

### Installation

```
bundle
```

#### Developer Installation

```
$ bundle
$ yarn
```

The difference in installation is that `yarn` installs `aglio` which is used for
generating documentation.

### Database creation

```
$ rails db:migrate
```

#### Create users to play with

This creates a few users to play with.

```
$ rails db:seed
```

By default, it creates (if run before creating any other users):
- Bill Murray, id: 1
- Tina Fey, id: 2

## To run

```
$ rails server
```

It is now running on `localhost:3000`

## Test suite

To run the included test suite:

```
$ rspec
```
