# freckle

Ruby client for [Version 2 of the Freckle API](http://developer.letsfreckle.com/v2/).


## Quick start

```ruby
require 'freckle'

freckle = Freckle::Client.new(token: 'YOUR PERSONAL ACCESS TOKEN')

freckle.get_projects.each do |project|
  puts project.name
end
```
