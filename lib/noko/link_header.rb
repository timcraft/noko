require 'noko/record'
require 'uri'

module Noko::LinkHeader
  extend self

  REGEXP = /<([^>]+)>; rel="(\w+)"/

  def parse(string)
    string.scan(REGEXP).each_with_object(Noko::Record.new) do |(uri, rel), record|
      record[rel.to_sym] = URI.parse(uri).request_uri
    end
  end
end
