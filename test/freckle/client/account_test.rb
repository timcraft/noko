require_relative '../client_test'

class FreckleClientAccountTest < FreckleClientTest
  def test_get_account
    expect_request(:get, "#{base_url}/account").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.get_account
  end
end
