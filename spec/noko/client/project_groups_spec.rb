require 'spec_helper'

RSpec.describe 'Noko::Client project_groups methods' do
  include_context 'Noko::Client'

  describe '#get_project_groups' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/project_groups").with(auth_header).to_return(json_array_response)

      expect(client.get_project_groups).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/project_groups?name=Sprockets")

      client.get_project_groups(name: 'Sprockets')
    end
  end

  describe '#get_project_group' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/project_groups/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_project_group(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#create_project_group' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/project_groups").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_project_group(name: 'Sprockets, Inc.')).to be_instance_of(Noko::Record)
    end
  end

  describe '#get_project_group_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/project_groups/#{id}/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_project_group_entries(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/project_groups/#{id}/entries?billable=true")

      client.get_project_group_entries(id, billable: true)
    end
  end

  describe '#get_project_group_projects' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/project_groups/#{id}/projects").with(auth_header).to_return(json_array_response)

      expect(client.get_project_group_projects(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/project_groups/#{id}/projects?billable=true")

      client.get_project_group_projects(id, billable: true)
    end
  end

  describe '#update_project_group' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/project_groups/#{id}").with(json_request).to_return(json_response)

      expect(client.update_project_group(id, name: 'Sprockets, Inc.')).to be_instance_of(Noko::Record)
    end
  end

  describe '#delete_project_group' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/project_groups/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_project_group(id)).to eq(:no_content)
    end
  end
end
