# frozen_string_literal: true
require 'net/http'
require 'json'

module Noko
  module Response
    extend self

    def parse(response)
      if response.is_a?(Net::HTTPNoContent)
        return :no_content
      end

      if response.content_type == 'application/json'
        object = JSON.parse(response.body, symbolize_names: true, object_class: Record)

        if response['Link']
          object.singleton_class.module_eval { attr_accessor :link }
          object.link = LinkHeader.parse(response['Link'])
        end

        return object
      end

      response.body
    end

    def error(response)
      if response.content_type == 'application/json'
        body = JSON.parse(response.body)

        error_class(response).new(body['message'])
      else
        error_class(response)
      end
    end

    def error_class(object)
      case object
      when Net::HTTPBadRequest then Noko::ClientError
      when Net::HTTPUnauthorized then Noko::AuthenticationError
      when Net::HTTPNotFound then Noko::NotFound
      when Net::HTTPClientError then Noko::ClientError
      when Net::HTTPServerError then Noko::ServerError
      else
        Noko::Error
      end
    end
  end
end
