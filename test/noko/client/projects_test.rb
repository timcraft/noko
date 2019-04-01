require_relative '../client_test'

class ClientProjectsTest < ClientTest
  def test_get_projects
    expect_request(:get, "#{base_url}/projects").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_projects
  end

  def test_get_projects_encodes_params
    expect_request(:get, "#{base_url}/projects?billable=true")

    client.get_projects(billable: true)
  end

  def test_get_project
    expect_request(:get, "#{base_url}/projects/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Noko::Record, client.get_project(id)
  end

  def test_create_project
    expect_request(:post, "#{base_url}/projects").with(json_request).to_return(json_response.merge(status: 201))

    assert_instance_of Noko::Record, client.create_project(name: 'Gear GmbH')
  end

  def test_get_project_entries
    expect_request(:get, "#{base_url}/projects/#{id}/entries").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_project_entries(id)
  end

  def test_get_project_entries_encodes_params
    expect_request(:get, "#{base_url}/projects/#{id}/entries?billable=true")

    client.get_project_entries(id, billable: true)
  end

  def test_get_project_expenses
    expect_request(:get, "#{base_url}/projects/#{id}/expenses").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_project_expenses(id)
  end

  def test_get_project_expenses_encodes_params
    expect_request(:get, "#{base_url}/projects/#{id}/expenses?invoiced=true")

    client.get_project_expenses(id, invoiced: true)
  end

  def test_update_project
    expect_request(:put, "#{base_url}/projects/#{id}").with(json_request).to_return(json_response)

    assert_instance_of Noko::Record, client.update_project(id, color: '#ff9898')
  end

  def test_merge_projects
    expect_request(:put, "#{base_url}/projects/#{id}/merge").with(json_request.merge(body: '{"project_id":5678}')).to_return(status: 204)

    assert_equal :no_content, client.merge_projects(id, 5678)
  end

  def test_delete_project
    expect_request(:delete, "#{base_url}/projects/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_project(id)
  end

  def test_archive_project
    expect_request(:put, "#{base_url}/projects/#{id}/archive").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.archive_project(id)
  end

  def test_unarchive_project
    expect_request(:put, "#{base_url}/projects/#{id}/unarchive").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.unarchive_project(id)
  end

  def test_archive_projects
    expect_request(:put, "#{base_url}/projects/archive").with(json_request.merge(body: '{"project_ids":[123]}')).to_return(status: 204)

    assert_equal :no_content, client.archive_projects([id])
  end

  def test_unarchive_projects
    expect_request(:put, "#{base_url}/projects/unarchive").with(json_request.merge(body: '{"project_ids":[123]}')).to_return(status: 204)

    assert_equal :no_content, client.unarchive_projects([id])
  end

  def test_delete_projects
    expect_request(:put, "#{base_url}/projects/delete").with(json_request.merge(body: '{"project_ids":[123]}')).to_return(status: 204)

    assert_equal :no_content, client.delete_projects([id])
  end
end
