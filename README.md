# noko

[![Gem Version](https://badge.fury.io/rb/noko.svg)](https://badge.fury.io/rb/noko) [![Test Status](https://github.com/timcraft/noko/actions/workflows/test.yml/badge.svg)](https://github.com/timcraft/noko/actions/workflows/test.yml)

Ruby client for the [Noko API](https://developer.nokotime.com/v2/).


## Install

Using Bundler:

    $ bundle add noko

Using RubyGems:

    $ gem install noko


## Getting started

```ruby
require 'noko'

noko = Noko::Client.new(token: ENV.fetch('NOKO_TOKEN'))

noko.get_projects.each do |project|
  puts project.name
end
```
