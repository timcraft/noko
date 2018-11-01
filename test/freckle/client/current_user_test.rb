require_relative '../client_test'

class FreckleClientCurrentUserTest < FreckleClientTest
  def test_get_current_user
    expect_request(:get, "#{base_url}/current_user").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.get_current_user
  end

  def test_get_current_user_entries
    expect_request(:get, "#{base_url}/current_user/entries").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_current_user_entries
  end

  def test_get_current_user_entries_encodes_params
    expect_request(:get, "#{base_url}/current_user/entries?billable=true")

    client.get_current_user_entries(billable: true)
  end

  def test_get_current_user_expenses
    expect_request(:get, "#{base_url}/current_user/expenses").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_current_user_expenses
  end

  def test_get_current_user_expenses_encodes_params
    expect_request(:get, "#{base_url}/current_user/expenses?invoiced=true")

    client.get_current_user_expenses(invoiced: true)
  end

  def test_update_current_user
    expect_request(:put, "#{base_url}/current_user").with(json_request).to_return(json_response)

    assert_instance_of Freckle::Record, client.update_current_user(week_start: 'monday')
  end
end
