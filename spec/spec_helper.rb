require_relative '../lib/noko'
require 'webmock/rspec'

RSpec.shared_context 'Noko::Client' do
  let(:token) { 'token-xxx' }
  let(:id) { 123 }
  let(:ids) { %w[123 456 789] }
  let(:base_url) { 'https://api.nokotime.com/v2' }
  let(:auth_header) { {headers: {'X-NokoToken' => token}} }
  let(:json_request) { {headers: {'X-NokoToken' => token, 'Content-Type' => 'application/json'}, body: /\A{.+}\z/} }
  let(:json_response_headers) { {'Content-Type' => 'application/json;charset=utf-8'} }
  let(:json_response) { {headers: json_response_headers, body: '{}'} }
  let(:json_array_response) { {headers: json_response_headers, body: '[]'} }
  let(:client) { Noko::Client.new(token: token) }

  before do
    WebMock.reset!

    @request = nil
  end

  after do
    expect(@request).to have_been_made.times(1) if @request
  end

  def expect_request(*args)
    @request = stub_request(*args)
  end
end
