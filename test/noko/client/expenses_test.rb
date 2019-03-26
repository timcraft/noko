require_relative '../client_test'

class ClientExpensesTest < ClientTest
  def test_get_expenses
    expect_request(:get, "#{base_url}/expenses").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_expenses
  end

  def test_get_expenses_encodes_params
    expect_request(:get, "#{base_url}/expenses?invoiced=true")

    client.get_expenses(invoiced: true)
  end

  def test_get_expenses_encodes_ids
    expect_request(:get, "#{base_url}/expenses?project_ids=123,456,789")

    client.get_expenses(project_ids: ids)
  end

  def test_get_expense
    expect_request(:get, "#{base_url}/expenses/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Noko::Record, client.get_expense(id)
  end

  def test_create_expense
    expect_request(:post, "#{base_url}/expenses").with(json_request).to_return(json_response.merge(status: 201))

    assert_instance_of Noko::Record, client.create_expense(date: Date.today, project_id: id, price: '14.55')
  end

  def test_update_expense
    expect_request(:put, "#{base_url}/expenses/#{id}").with(json_request).to_return(json_response)

    assert_instance_of Noko::Record, client.update_expense(id, price: '19.99')
  end

  def test_delete_expense
    expect_request(:delete, "#{base_url}/expenses/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_expense(id)
  end
end
