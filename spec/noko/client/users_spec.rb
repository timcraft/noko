require 'spec_helper'

RSpec.describe 'Noko::Client users methods' do
  include_context 'Noko::Client'

  describe '#get_users' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/users").with(auth_header).to_return(json_array_response)

      expect(client.get_users).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/users?name=John")

      client.get_users(name: 'John')
    end
  end

  describe '#get_user' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/users/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_user(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#get_user_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/users/#{id}/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_user_entries(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/users/#{id}/entries?billable=true")

      client.get_user_entries(id, billable: true)
    end
  end

  describe '#get_user_expenses' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/users/#{id}/expenses").with(auth_header).to_return(json_array_response)

      expect(client.get_user_expenses(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/users/#{id}/expenses?invoiced=true")

      client.get_user_expenses(id, invoiced: true)
    end
  end

  describe '#create_user' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/users").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_user(email: 'alice@example.com')).to be_instance_of(Noko::Record)
    end
  end

  describe '#update_user' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/users/#{id}").with(json_request).to_return(json_response)

      expect(client.update_user(id, role: 'leader')).to be_instance_of(Noko::Record)
    end
  end

  describe '#delete_user' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/users/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_user(id)).to eq(:no_content)
    end
  end

  describe '#reactivate_user' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/users/#{id}/activate").with(auth_header).to_return(status: 204)

      expect(client.reactivate_user(id)).to eq(:no_content)
    end
  end

  describe '#deactivate_user' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/users/#{id}/deactivate").with(auth_header).to_return(status: 204)

      expect(client.deactivate_user(id)).to eq(:no_content)
    end
  end
end
