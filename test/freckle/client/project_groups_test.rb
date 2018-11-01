require_relative '../client_test'

class FreckleClientProjectGroupsTest < FreckleClientTest
  def test_get_project_groups
    expect_request(:get, "#{base_url}/project_groups").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_project_groups
  end

  def test_get_project_groups_encodes_params
    expect_request(:get, "#{base_url}/project_groups?name=Sprockets")

    client.get_project_groups(name: 'Sprockets')
  end

  def test_get_project_group
    expect_request(:get, "#{base_url}/project_groups/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.get_project_group(id)
  end

  def test_create_project_group
    expect_request(:post, "#{base_url}/project_groups").with(json_request).to_return(json_response.merge(status: 201))

    assert_instance_of Freckle::Record, client.create_project_group(name: 'Sprockets, Inc.')
  end

  def test_get_project_group_entries
    expect_request(:get, "#{base_url}/project_groups/#{id}/entries").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_project_group_entries(id)
  end

  def test_get_project_group_entries_encodes_params
    expect_request(:get, "#{base_url}/project_groups/#{id}/entries?billable=true")

    client.get_project_group_entries(id, billable: true)
  end

  def test_get_project_group_projects
    expect_request(:get, "#{base_url}/project_groups/#{id}/projects").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_project_group_projects(id)
  end

  def test_get_project_group_projects_encodes_params
    expect_request(:get, "#{base_url}/project_groups/#{id}/projects?billable=true")

    client.get_project_group_projects(id, billable: true)
  end

  def test_update_project_group
    expect_request(:put, "#{base_url}/project_groups/#{id}").with(json_request).to_return(json_response)

    assert_instance_of Freckle::Record, client.update_project_group(id, name: 'Sprockets, Inc.')
  end

  def test_delete_project_group
    expect_request(:delete, "#{base_url}/project_groups/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_project_group(id)
  end
end
