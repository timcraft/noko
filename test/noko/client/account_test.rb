require_relative '../client_test'

class ClientAccountTest < ClientTest
  def test_get_account
    expect_request(:get, "#{base_url}/account").with(auth_header).to_return(json_response)

    assert_instance_of Noko::Record, client.get_account
  end
end
