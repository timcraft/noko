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

  def test_get_webhooks_encodes_event_params
    skip("test this after I make a webhook")
    expect_request(:get, "#{base_url}/webhooks?events=entry.updated,entry.updated.approved")

    client.get_webhooks(events: "entry.updated, entry.updated.approved")
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
  # def test_update_webhook
  # def test_add_webhook_events
  # def test_delete_webhook_events
  # def test_reroll_webhook_secret
  # def test_disable_webhook
  # def test_enable_webhook
  # def test_delete_webhook
end
