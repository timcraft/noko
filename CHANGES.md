# 1.4.0

* **(breaking change)** Renamed gem from freckles to noko. Steps to upgrade:

  - rename the gem in your Gemfile from `gem 'freckles'` to `gem 'noko'`
  - rename any requires from `require 'freckle'` to `require 'noko'`
  - rename any module references from `Freckle` to `Noko`

# 1.3.0

* Updated to use nokotime.com hostnames (thanks @madrobby)

* Updated to use X-NokoToken header

# 1.2.0

* Added methods for project group resources

* Changed default user agent header to include version numbers

* Removed deprecated #next_page attribute

# 1.1.0

* Added methods for returning Link header pagination urls

* Deprecated #next_page attribute

# 1.0.0

* First version!
