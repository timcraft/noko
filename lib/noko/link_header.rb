require 'noko/record'
require 'uri'

module Noko
  module LinkHeader # :nodoc:
    extend self

    REGEXP = /<([^>]+)>; rel="(\w+)"/

    def parse(string)
      string.scan(REGEXP).each_with_object(Record.new) do |(uri, rel), record|
        record[rel.to_sym] = URI.parse(uri).request_uri
      end
    end
  end
end
