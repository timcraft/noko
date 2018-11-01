require_relative '../client_test'

class FreckleClientTagsTest < FreckleClientTest
  def test_get_tags
    expect_request(:get, "#{base_url}/tags").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_tags
  end

  def test_get_tags_encodes_params
    expect_request(:get, "#{base_url}/tags?billable=true")

    client.get_tags(billable: true)
  end

  def test_create_tags
    expect_request(:post, "#{base_url}/tags").with(json_request).to_return(json_array_response.merge(status: 201))

    assert_equal [], client.create_tags(%w[freckle])
  end

  def test_get_tag
    expect_request(:get, "#{base_url}/tags/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.get_tag(id)
  end

  def test_get_tag_entries
    expect_request(:get, "#{base_url}/tags/#{id}/entries").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_tag_entries(id)
  end

  def test_get_tag_entries_encodes_params
    expect_request(:get, "#{base_url}/tags/#{id}/entries?billable=true")

    client.get_tag_entries(id, billable: true)
  end

  def test_update_tag
    expect_request(:put, "#{base_url}/tags/#{id}").with(json_request).to_return(json_response)

    assert_instance_of Freckle::Record, client.update_tag(id, name: 'freckle')
  end

  def test_merge_tags
    expect_request(:put, "#{base_url}/tags/#{id}/merge").with(json_request.merge(body: '{"tag_id":5678}')).to_return(status: 204)

    assert_equal :no_content, client.merge_tags(id, 5678)
  end

  def test_delete_tag
    expect_request(:delete, "#{base_url}/tags/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_tag(id)
  end

  def test_delete_tags
    expect_request(:put, "#{base_url}/tags/delete").with(json_request.merge(body: '{"tag_ids":[123]}')).to_return(status: 204)

    assert_equal :no_content, client.delete_tags([id])
  end
end
