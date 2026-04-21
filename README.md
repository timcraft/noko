# noko

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
