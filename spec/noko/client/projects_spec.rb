require 'spec_helper'

RSpec.describe 'Noko::Client projects methods' do
  include_context 'Noko::Client'

  describe '#get_projects' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/projects").with(auth_header).to_return(json_array_response)

      expect(client.get_projects).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/projects?billable=true")

      client.get_projects(billable: true)
    end
  end

  describe '#get_project' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/projects/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_project(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#create_project' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/projects").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_project(name: 'Gear GmbH')).to be_instance_of(Noko::Record)
    end
  end

  describe '#get_project_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/projects/#{id}/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_project_entries(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/projects/#{id}/entries?billable=true")

      client.get_project_entries(id, billable: true)
    end
  end

  describe '#get_project_expenses' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/projects/#{id}/expenses").with(auth_header).to_return(json_array_response)

      expect(client.get_project_expenses(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/projects/#{id}/expenses?invoiced=true")

      client.get_project_expenses(id, invoiced: true)
    end
  end

  describe '#update_project' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/projects/#{id}").with(json_request).to_return(json_response)

      expect(client.update_project(id, color: '#ff9898')).to be_instance_of(Noko::Record)
    end
  end

  describe '#merge_projects' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/projects/#{id}/merge").with(json_request.merge(body: '{"project_id":5678}')).to_return(status: 204)

      expect(client.merge_projects(id, 5678)).to eq(:no_content)
    end
  end

  describe '#delete_project' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/projects/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_project(id)).to eq(:no_content)
    end
  end

  describe '#archive_project' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/projects/#{id}/archive").with(auth_header).to_return(status: 204)

      expect(client.archive_project(id)).to eq(:no_content)
    end
  end

  describe '#unarchive_project' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/projects/#{id}/unarchive").with(auth_header).to_return(status: 204)

      expect(client.unarchive_project(id)).to eq(:no_content)
    end
  end

  describe '#archive_projects' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/projects/archive").with(json_request.merge(body: '{"project_ids":[123]}')).to_return(status: 204)

      expect(client.archive_projects([id])).to eq(:no_content)
    end
  end

  describe '#unarchive_projects' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/projects/unarchive").with(json_request.merge(body: '{"project_ids":[123]}')).to_return(status: 204)

      expect(client.unarchive_projects([id])).to eq(:no_content)
    end
  end

  describe '#delete_projects' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/projects/delete").with(json_request.merge(body: '{"project_ids":[123]}')).to_return(status: 204)

      expect(client.delete_projects([id])).to eq(:no_content)
    end
  end
end
