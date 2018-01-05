# freckles

[![Gem Version](https://badge.fury.io/rb/freckles.svg)](https://badge.fury.io/rb/freckles) [![Build Status](https://api.travis-ci.org/timcraft/freckles.svg?branch=master)](https://travis-ci.org/timcraft/freckles)


Ruby client for [Version 2 of the Freckle API](http://developer.letsfreckle.com/v2/).


## Install

```
$ gem install freckles
```


## Quick start

```ruby
require 'freckle'

freckle = Freckle::Client.new(token: 'YOUR PERSONAL ACCESS TOKEN')

freckle.get_projects.each do |project|
  puts project.name
end
```
