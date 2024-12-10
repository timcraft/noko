# frozen_string_literal: true
require 'uri'

module Noko
  module Params
    extend self

    def join(path, params = nil)
      return path if params.nil? || params.empty?

      path + '?' + encode(params)
    end

    def encode(params)
      params.map { |k, v| escape(k) + '=' + Array(v).map { escape(_1) }.join(',') }.join('&')
    end

    def escape(value)
      URI.encode_uri_component(value)
    end
  end
end
