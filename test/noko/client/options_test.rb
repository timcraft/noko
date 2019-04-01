require_relative '../client_test'

class ClientOptionsTest < ClientTest
  def user_agent
    'account.nokotime.com'
  end

  def access_token
    'oauth2-access-token'
  end

  def test_user_agent_option
    client = Noko::Client.new(token: token, user_agent: user_agent)

    expect_request(:get, "#{base_url}/entries").with(headers: {'User-Agent' => user_agent})

    client.get_entries
  end

  def test_access_token_option
    client = Noko::Client.new(access_token: access_token)

    expect_request(:get, "#{base_url}/entries").with(headers: {'Authorization' => 'token oauth2-access-token'})

    client.get_entries
  end
end
