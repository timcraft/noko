require_relative '../client_test'

class FreckleClientTimersTest < FreckleClientTest
  def test_get_timers
    expect_request(:get, "#{base_url}/timers").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_timers
  end

  def test_get_timers_encodes_params
    expect_request(:get, "#{base_url}/timers?billable=true")

    client.get_timers(billable: true)
  end

  def test_get_timers_encodes_ids
    expect_request(:get, "#{base_url}/timers?projects=123,456,789")

    client.get_timers(projects: ids)
  end

  def test_get_timer
    expect_request(:get, "#{base_url}/projects/#{id}/timer").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.get_timer(id)
  end

  def test_update_timer
    expect_request(:put, "#{base_url}/projects/#{id}/timer").with(json_request).to_return(json_response)

    assert_instance_of Freckle::Record, client.update_timer(id, description: 'Notes go here')
  end

  def test_start_timer
    expect_request(:put, "#{base_url}/projects/#{id}/timer/start").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.start_timer(id)
  end

  def test_pause_timer
    expect_request(:put, "#{base_url}/projects/#{id}/timer/pause").with(auth_header).to_return(json_response)

    assert_instance_of Freckle::Record, client.pause_timer(id)
  end

  def test_log_timer
    expect_request(:put, "#{base_url}/projects/#{id}/timer/log").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.log_timer(id, description: 'Serious #development work')
  end

  def test_discard_timer
    expect_request(:delete, "#{base_url}/projects/#{id}/timer").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.discard_timer(id)
  end
end
