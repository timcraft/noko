require 'spec_helper'

RSpec.describe 'Noko::Client webhooks methods' do
  include_context 'Noko::Client'

  describe '#get_webhooks' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/webhooks").with(auth_header).to_return(json_array_response)

      expect(client.get_webhooks).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/webhooks?name=Notifier")

      client.get_webhooks(name: 'Notifier')
    end
  end

  describe '#get_webhook' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/webhooks/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_webhook(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#create_webhook' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/webhooks").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_webhook(name: 'My Webhook', payload_uri: 'http://testnokoapp.com/webhooks/entry_events', events: ['*'])).to be_instance_of(Noko::Record)
    end
  end

  describe '#update_webhook' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/webhooks/#{id}").with(json_request).to_return(json_response)

      expect(client.update_webhook(id, name: 'The Best Webhook', payload_uri: 'http://dabestnokoapp.com/webhooks/entry_events')).to be_instance_of(Noko::Record)
    end
  end

  describe '#add_webhook_events' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/webhooks/#{id}/add_events").with(json_request).to_return(json_response)

      expect(client.add_webhook_events(id, events: ['entry.updated'])).to be_instance_of(Noko::Record)
    end
  end

  describe '#remove_webhook_events' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/webhooks/#{id}/remove_events").with(json_request).to_return(json_response)

      expect(client.remove_webhook_events(id, events: ['tag.created', 'tag.deleted.merged'])).to be_instance_of(Noko::Record)
    end
  end

  describe '#reroll_webhook_secret' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/webhooks/#{id}/reroll_secret").with(auth_header).to_return(json_response)

      expect(client.reroll_webhook_secret(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#disable_webhook' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/webhooks/#{id}/disable").with(auth_header).to_return(status: 204)

      expect(client.disable_webhook(id)).to eq(:no_content)
    end
  end

  describe '#enable_webhook' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/webhooks/#{id}/enable").with(auth_header).to_return(status: 204)

      expect(client.enable_webhook(id)).to eq(:no_content)
    end
  end

  describe '#delete_webhook' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/webhooks/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_webhook(id)).to eq(:no_content)
    end
  end
end
