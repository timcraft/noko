# noko

[![Gem Version](https://badge.fury.io/rb/noko.svg)](https://badge.fury.io/rb/noko) [![Build Status](https://api.travis-ci.org/timcraft/noko.svg?branch=master)](https://travis-ci.org/timcraft/noko)


Ruby client for [Version 2 of the Noko/Freckle API](https://developer.nokotime.com/v2/).


## Install

Install using RubyGems:

```
$ gem install noko
```

Add it to your Gemfile and install using Bundler:

```ruby
gem 'noko'
```

Clone the repository:

```
git clone git@github.com:timcraft/noko.git
```


## Quick start

```ruby
require 'noko'

noko = Noko::Client.new(token: 'YOUR PERSONAL ACCESS TOKEN')

noko.get_projects.each do |project|
  puts project.name
end
```
