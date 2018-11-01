require_relative '../client_test'

class FreckleClientErrorsTest < FreckleClientTest
  def test_bad_request_errors
    message = 'The Project cannot be deleted because it has entries, expenses, or invoices.'

    response = json_response.merge(status: 400, body: %({"message":"#{message}"}))

    stub_request(:delete, "#{base_url}/projects/#{id}").to_return(response)

    exception = assert_raises(Freckle::Error) do
      client.delete_project(id)
    end

    assert_includes exception.message, message
  end

  def test_authentication_errors
    response = json_response.merge(status: 401)

    stub_request(:get, "#{base_url}/entries").to_return(response)

    assert_raises(Freckle::AuthenticationError) do
      client.get_entries
    end
  end
end
