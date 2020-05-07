require_relative '../client_test'

class ClientWebhooksTest < ClientTest
  def test_get_webhooks
    expect_request(:get, "#{base_url}/webhooks").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_webhooks
  end

  def test_get_webhooks_encodes_name_params
    expect_request(:get, "#{base_url}/webhooks?name=Notifier")

    client.get_webhooks(name: "Notifier")
  end

  def test_get_webhooks_encodes_state_params
    expect_request(:get, "#{base_url}/webhooks?state=disabled")

    client.get_webhooks(state: "disabled")
  end

  def test_get_webhook
    expect_request(:get, "#{base_url}/webhooks/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Noko::Record, client.get_webhook(id)
  end

  def test_create_webhook
    expect_request(:post, "#{base_url}/webhooks").with(json_request).to_return(json_response.merge(status: 201))

    assert_instance_of Noko::Record, client.create_webhook(name: "My Webhook", payload_uri: "http://testnokoapp.com/webhooks/entry_events", events: ["*"])
  end

  def test_update_webhook
    expect_request(:put, "#{base_url}/webhooks/#{id}").with(json_request).to_return(json_response).to_return(status: 200)

    assert_instance_of Noko::Record, client.update_webhook(id, name: "The Best Webhook", payload_uri: "http://dabestnokoapp.com/webhooks/entry_events")
  end

  def test_add_webhook_events
    expect_request(:put, "#{base_url}/webhooks/#{id}/add_events").with(json_request).to_return(json_response).to_return(status: 200)

    assert_instance_of Noko::Record, client.add_webhook_events(id, events: ["entry.updated"])
  end

  def test_remove_webhook_events
    expect_request(:put, "#{base_url}/webhooks/#{id}/remove_events").with(json_request).to_return(json_response).to_return(status: 200)

    assert_instance_of Noko::Record, client.remove_webhook_events(id, events: ["tag.created","tag.deleted.merged")
  end

  def test_reroll_webhook_secret
    expect_request(:put, "#{base_url}/webhooks/#{id}/reroll_secret").with(json_request).to_return(json_response).to_return(status: 200)

    assert_instance_of Noko::Record, client.reroll_webhook_secret(id)
  end

  def test_disable_webhook
    expect_request(:put, "#{base_url}/webhooks/#{id}/disable").with(json_request).to_return(json_response).to_return(status: 204)

    assert_instance_of Noko::Record, client.disable_webhook(id)
  end

  def test_enable_webhook
    expect_request(:put, "#{base_url}/webhooks/#{id}/enable").with(json_request).to_return(json_response).to_return(status: 204)

    assert_instance_of Noko::Record, client.enable_webhook(id)
  end

  def test_delete_webhook
    expect_request(:delete, "#{base_url}/webhooks/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_webhook(id)
  end
end
