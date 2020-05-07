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
    expect_request(:get, "#{base_url}/webhooks?events=entry.updated,entry.updated.approved")

    client.get_webhooks(events: "entry.updated, entry.updated.approved")
  end

  # def test_get_webhook
  # def test_create_webhook
  # def test_update_webhook
  # def test_add_webhook_events
  # def test_delete_webhook_events
  # def test_reroll_webhook_secret
  # def test_disable_webhook
  # def test_enable_webhook
  # def test_delete_webhook
end
