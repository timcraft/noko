require 'spec_helper'

RSpec.describe 'Noko::Client timers methods' do
  include_context 'Noko::Client'

  describe '#get_timers' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/timers").with(auth_header).to_return(json_array_response)

      expect(client.get_timers).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/timers?billable=true")

      client.get_timers(billable: true)
    end

    it 'encodes ids' do
      expect_request(:get, "#{base_url}/timers?projects=123,456,789")

      client.get_timers(projects: ids)
    end
  end

  describe '#get_timer' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/projects/#{id}/timer").with(auth_header).to_return(json_response)

      expect(client.get_timer(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#update_timer' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/projects/#{id}/timer").with(json_request).to_return(json_response)

      expect(client.update_timer(id, description: 'Notes go here')).to be_instance_of(Noko::Record)
    end
  end

  describe '#start_timer' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/projects/#{id}/timer/start").with(auth_header).to_return(json_response)

      expect(client.start_timer(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#pause_timer' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/projects/#{id}/timer/pause").with(auth_header).to_return(json_response)

      expect(client.pause_timer(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#log_timer' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/projects/#{id}/timer/log").with(auth_header).to_return(status: 204)

      expect(client.log_timer(id, description: 'Serious #development work')).to eq(:no_content)
    end
  end

  describe '#discard_timer' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/projects/#{id}/timer").with(auth_header).to_return(status: 204)

      expect(client.discard_timer(id)).to eq(:no_content)
    end
  end
end
