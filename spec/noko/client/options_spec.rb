require 'spec_helper'

RSpec.describe 'Noko::Client options' do
  include_context 'Noko::Client'

  describe 'user_agent option' do
    let(:user_agent) { 'account.nokotime.com' }

    it 'specifies the user agent header to use' do
      client = Noko::Client.new(token: token, user_agent: user_agent)

      expect_request(:get, "#{base_url}/entries").with(headers: {'User-Agent' => user_agent})

      client.get_entries
    end
  end

  describe 'access_token option' do
    let(:access_token) { 'oauth2-access-token' }

    it 'specifies the access token to use' do
      client = Noko::Client.new(access_token: access_token)

      expect_request(:get, "#{base_url}/entries").with(headers: {'Authorization' => 'token oauth2-access-token'})

      client.get_entries
    end
  end
end
