require_relative '../client_test'

class FreckleClientUsersTest < FreckleClientTest
  def test_get_users
    expect_request(:get, "#{base_url}/users").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_users
  end

  def test_get_users_encodes_params
    expect_request(:get, "#{base_url}/users?name=John")

    client.get_users(name: 'John')
  end

  def test_get_user
    expect_request(:get, "#{base_url}/users/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.get_user(id)
  end

  def test_get_user_entries
    expect_request(:get, "#{base_url}/users/#{id}/entries").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_user_entries(id)
  end

  def test_get_user_entries_encodes_params
    expect_request(:get, "#{base_url}/users/#{id}/entries?billable=true")

    client.get_user_entries(id, billable: true)
  end

  def test_get_user_expenses
    expect_request(:get, "#{base_url}/users/#{id}/expenses").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_user_expenses(id)
  end

  def test_get_user_expenses_encodes_params
    expect_request(:get, "#{base_url}/users/#{id}/expenses?invoiced=true")

    client.get_user_expenses(id, invoiced: true)
  end

  def test_create_user
    expect_request(:post, "#{base_url}/users").with(json_request).to_return(json_response.merge(status: 201))

    assert_instance_of Freckle::Record, client.create_user(email: 'alice@example.com')
  end

  def test_update_user
    expect_request(:put, "#{base_url}/users/#{id}").with(json_request).to_return(json_response)

    assert_instance_of Freckle::Record, client.update_user(id, role: 'leader')
  end

  def test_delete_user
    expect_request(:delete, "#{base_url}/users/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_user(id)
  end

  def test_reactivate_user
    expect_request(:put, "#{base_url}/users/#{id}/activate").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.reactivate_user(id)
  end

  def test_deactivate_user
    expect_request(:put, "#{base_url}/users/#{id}/deactivate").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.deactivate_user(id)
  end
end
