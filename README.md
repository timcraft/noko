# freckles

[![Gem Version](https://badge.fury.io/rb/freckles.svg)](https://badge.fury.io/rb/freckles) [![Build Status](https://api.travis-ci.org/timcraft/freckles.svg?branch=master)](https://travis-ci.org/timcraft/freckles)


Ruby client for [Version 2 of the Freckle API](https://developer.letsfreckle.com/v2/).


## Install

Install using RubyGems:

```
$ gem install freckles
```

Add it to your Gemfile and install using Bundler:

```ruby
gem 'freckles', require: 'freckle'
```

Clone the repository:

```
git clone git@github.com:timcraft/freckles.git
```


## Quick start

```ruby
require 'freckle'

freckle = Freckle::Client.new(token: 'YOUR PERSONAL ACCESS TOKEN')

freckle.get_projects.each do |project|
  puts project.name
end
```
