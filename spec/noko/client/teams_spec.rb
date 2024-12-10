require 'spec_helper'

RSpec.describe 'Noko::Client teams methods' do
  include_context 'Noko::Client'

  describe '#get_teams' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/teams").with(auth_header).to_return(json_array_response)

      expect(client.get_teams).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/teams?name=Sprockets")

      client.get_teams(name: 'Sprockets')
    end
  end

  describe '#get_team' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/teams/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_team(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#create_team' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/teams").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_team(name: 'R&D')).to be_instance_of(Noko::Record)
    end
  end

  describe '#update_team' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/teams/#{id}").with(json_request).to_return(json_response)

      expect(client.update_team(id, name: 'R&D')).to be_instance_of(Noko::Record)
    end
  end

  describe '#get_team_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/teams/#{id}/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_team_entries(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/teams/#{id}/entries?billable=true")

      client.get_team_entries(id, billable: true)
    end
  end

  describe '#get_team_users' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/teams/#{id}/users").with(auth_header).to_return(json_array_response)

      expect(client.get_team_users(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/teams/#{id}/users?role=contractor")

      client.get_team_users(id, role: 'contractor')
    end
  end

  describe '#add_team_users' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/teams/#{id}/add_users").with(json_request).to_return(json_response)

      expect(client.add_team_users(id, user_ids: ids)).to be_instance_of(Noko::Record)
    end
  end

  describe '#remove_team_users' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/teams/#{id}/remove_users").with(json_request).to_return(status: 204)

      expect(client.remove_team_users(id, user_ids: ids)).to eq(:no_content)
    end
  end

  describe '#remove_all_team_users' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/teams/#{id}/remove_all_users").with(auth_header).to_return(status: 204)

      expect(client.remove_all_team_users(id)).to eq(:no_content)
    end
  end

  describe '#delete_team' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/teams/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_team(id)).to eq(:no_content)
    end
  end
end
