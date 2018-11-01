require 'minitest/autorun'
require 'webmock/minitest'
require 'freckle'

class FreckleClientTest < Minitest::Test
  def token
    'freckle-token'
  end

  def id
    123
  end

  def ids
    %w[123 456 789]
  end

  def base_url
    'https://api.letsfreckle.com/v2'
  end

  def auth_header
    {headers: {'X-FreckleToken' => token}}
  end

  def json_request
    {headers: {'X-FreckleToken' => token, 'Content-Type' => 'application/json'}, body: /\A{.+}\z/}
  end

  def json_response_headers
    {'Content-Type' => 'application/json;charset=utf-8'}
  end

  def json_response
    {headers: json_response_headers, body: '{}'}
  end

  def json_array_response
    {headers: json_response_headers, body: '[]'}
  end

  attr_accessor :client
  attr_accessor :request

  def setup
    WebMock.reset!

    self.client = Freckle::Client.new(token: token)
    self.request = nil
  end

  def teardown
    assert_requested(request) if request
  end

  def expect_request(*args)
    self.request = stub_request(*args)
  end
end
