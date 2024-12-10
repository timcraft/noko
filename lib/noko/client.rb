# frozen_string_literal: true
require 'noko/version'
require 'noko/errors'
require 'noko/link_header'
require 'noko/params'
require 'noko/record'
require 'noko/response'
require 'net/http'
require 'json'

class Noko::Client
  def initialize(options = {})
    if options.key?(:access_token)
      @auth_header, @auth_value = 'Authorization', "token #{options[:access_token]}"
    elsif options.key?(:token)
      @auth_header, @auth_value = 'X-NokoToken', options.fetch(:token)
    elsif !(netrc = load_netrc_credentials).nil?
      @auth_header, @auth_value = 'X-NokoToken', netrc.password
    else
      raise ArgumentError, 'access_token or token required for authentication'
    end

    @user_agent = options.fetch(:user_agent) { "noko/#{Noko::VERSION} ruby/#{RUBY_VERSION}" }

    @host = 'api.nokotime.com'

    @http = Net::HTTP.new(@host, Net::HTTP.https_default_port)

    @http.use_ssl = true
  end

  def get(path, params = nil)
    request(Net::HTTP::Get.new(Noko::Params.join(path, params)))
  end

  private

  def post(path, attributes)
    request(Net::HTTP::Post.new(path), attributes)
  end

  def put(path, attributes = nil)
    request(Net::HTTP::Put.new(path), attributes)
  end

  def delete(path)
    request(Net::HTTP::Delete.new(path))
  end

  def request(http_request, body_object = nil)
    http_request['User-Agent'] = @user_agent
    http_request[@auth_header] = @auth_value

    if body_object
      http_request['Content-Type'] = 'application/json'
      http_request.body = JSON.generate(body_object)
    end

    response = @http.request(http_request)

    if response.is_a?(Net::HTTPSuccess)
      Noko::Response.parse(response)
    else
      raise Noko::Response.error(response)
    end
  end

  def load_netrc_credentials
    require 'net/netrc'

    Net::Netrc.locate('api.nokotime.com')
  rescue LoadError
  end
end
