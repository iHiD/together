# Together

Together helps you execute parallel code easily in different threads. It works particuarly well with the [Mandate](https://github.com/iHiD/mandate) gem.

## Usage

Together takes any objects that have `call` methods and executes them in parallel.

```
Together.(
  Proc.new { :foo },
  Proc.new { :bar }
)

# => [:foo, :bar]
```

By default Together has the following settings

- timeout after one seconds
-

These setting can be changed by the following:
- `timeout: 1`: How long before timing out?
- `raise_exceptions: true`: Raise any exceptions that happen in any of the sub-calls. If set to `false`, this will not raise exceptions but instead store them in an array called `exceptions`.

### Notes

The `timeout` param is applied from the moment the Together function is executed. Therefore the first thread gets a tiny amount longer to execute than the last. This is a deliberate decision.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'together'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install together

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Firstly, thank you!! :heart::sparkling_heart::heart:

We'd love to have you involved. Please read our [contributing guide](https://github.com/iHiD/together/tree/master/CONTRIBUTING.md) for information on how to get stuck in.

### Contributors

This project is managed by [Jeremy Walker](http://ihid.co.uk).

## Licence

Copyright (C) 2017 Jeremy Walker

This program is free software: you can redistribute it and/or modify
it under the terms of the MIT License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
MIT License for more details.

A copy of the MIT License is available in [LICENCE.md](https://github.com/iHiD/together/blob/master/LICENCE.md)
along with this program.
