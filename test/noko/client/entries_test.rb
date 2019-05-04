require_relative '../client_test'

class ClientEntriesTest < ClientTest
  def time
    Time.now.utc
  end

  def date
    Date.parse('2019-03-04')
  end

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

  def test_mark_entry_invoiced
    expect_request(:put, "#{base_url}/entries/#{id}/marked_as_invoiced").with(json_request).to_return(status: 204)

    assert_equal :no_content, client.mark_entry_invoiced(id, date: date)
  end

  def test_mark_entries_invoiced
    expect_request(:put, "#{base_url}/entries/marked_as_invoiced").with(json_request).to_return(status: 204)

    assert_equal :no_content, client.mark_entries_invoiced(entry_ids: ids, date: date)
  end

  def test_mark_entry_approved
    body = /\A{"approved_at":"\d{4}\-\d{2}\-\d{2}T\d{2}:\d{2}:\d{2}Z"}\z/

    expect_request(:put, "#{base_url}/entries/#{id}/approved").with(json_request(body)).to_return(status: 204)

    assert_equal :no_content, client.mark_entry_approved(id, approved_at: time.iso8601)
  end

  def test_mark_entries_approved
    expect_request(:put, "#{base_url}/entries/approved").with(json_request).to_return(status: 204)

    assert_equal :no_content, client.mark_entries_approved(entry_ids: ids, approved_at: time)
  end

  def test_mark_entry_unapproved
    expect_request(:put, "#{base_url}/entries/#{id}/unapproved").with(headers: {'X-NokoToken' => token}).to_return(status: 204)

    assert_equal :no_content, client.mark_entry_unapproved(id)
  end

  def test_mark_entries_unapproved
    expect_request(:put, "#{base_url}/entries/unapproved").with(json_request).to_return(status: 204)

    assert_equal :no_content, client.mark_entries_unapproved(entry_ids: ids)
  end
end
