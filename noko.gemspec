Gem::Specification.new do |s|
  s.name = 'noko'
  s.version = '1.5.0'
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'https://github.com/timcraft/noko'
  s.description = 'Ruby client for Version 2 of the Noko/Freckle API'
  s.summary = 'Ruby client for Version 2 of the Noko/Freckle API'
  s.files = Dir.glob('lib/**/*.rb') + %w(CHANGES.md LICENSE.txt README.md noko.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.require_path = 'lib'
end
