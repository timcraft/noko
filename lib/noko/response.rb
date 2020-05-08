require 'net/http'
require 'json'

module Noko
  module Response
    extend self

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

  private_constant :Response
end
