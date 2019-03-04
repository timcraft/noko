require_relative '../client_test'

class ClientEntriesTest < ClientTest
  def test_get_entries
    expect_request(:get, "#{base_url}/entries").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_entries
  end

  def test_get_entries_encodes_params
    expect_request(:get, "#{base_url}/entries?billable=true")

    client.get_entries(billable: true)
  end

  def test_get_entries_encodes_project_ids
    expect_request(:get, "#{base_url}/entries?project_ids=123,456,789")

    client.get_entries(project_ids: ids)
  end

  def test_get_entry
    expect_request(:get, "#{base_url}/entries/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Noko::Record, client.get_entry(id)
  end

  def test_create_entry
    expect_request(:post, "#{base_url}/entries").with(json_request).to_return(json_response.merge(status: 201))

    assert_instance_of Noko::Record, client.create_entry(date: Date.today, minutes: 60)
  end

  def test_update_entry
    expect_request(:put, "#{base_url}/entries/#{id}").with(json_request).to_return(json_response)

    assert_instance_of Noko::Record, client.update_entry(id, minutes: 120)
  end

  def test_delete_entry
    expect_request(:delete, "#{base_url}/entries/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_entry(id)
  end

  def test_entry_invoiced_outside_of_freckle
    expect_request(:put, "#{base_url}/entries/#{id}/invoiced_outside_of_freckle").with(json_request).to_return(json_response)

    assert_instance_of Freckle::Record, client.entry_invoiced_outside_of_freckle(id, date: '2018-09-01')
  end

  def test_entries_invoiced_outside_of_freckle
    expect_request(:put, "#{base_url}/entries/invoiced_outside_of_freckle").with(json_request).to_return(json_response)

    assert_instance_of Freckle::Record, client.entries_invoiced_outside_of_freckle(entry_ids: [2,2,3], date: '2018-09-01')
  end
end
