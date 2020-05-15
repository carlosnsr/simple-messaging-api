# Simple Messaging API

A simple messaging API done for my [Guild Education] technical test.

[Guild Education]: https://www.guildeducation.com/

## Documentation

Documentation describing this project is available in
[Markdown](./public/api/v1/apispec.md) and [HTML](./public/api/v1/index.html).

Documentation is generated from the RSpec examples, using [Dox](https://github.com/infinum/dox).

To regenerate the documentation:
```
$ rails api:docs:html`
```

To regenerate and view the documentation
```
$ rails api:docs:open`
```

## Configuration

### Dependencies

* Ruby 2.6.5
* Rails 6.0.3

### Developer Dependencies

As above, and:

* Node v12.16.3

### Installation

```
bundle
```

#### Developer Installation

```
$ bundle

# installs aglio for generating documentation
$ yarn
```

### Database creation

```
$ rails db:migrate
```

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
