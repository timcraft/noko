require 'spec_helper'

RSpec.describe 'Noko::Client current_user methods' do
  include_context 'Noko::Client'

  describe '#get_current_user' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/current_user").with(auth_header).to_return(json_response)

      expect(client.get_current_user).to be_instance_of(Noko::Record)
    end
  end

  describe '#get_current_user_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/current_user/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_current_user_entries).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/current_user/entries?billable=true")

      client.get_current_user_entries(billable: true)
    end
  end

  describe '#get_current_user_expenses' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/current_user/expenses").with(auth_header).to_return(json_array_response)

      expect(client.get_current_user_expenses).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/current_user/expenses?invoiced=true")

      client.get_current_user_expenses(invoiced: true)
    end
  end

  describe '#update_current_user' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/current_user").with(json_request).to_return(json_response)

      expect(client.update_current_user(week_start: 'monday')).to be_instance_of(Noko::Record)
    end
  end
end
