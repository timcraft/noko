require 'spec_helper'

RSpec.describe 'Noko::Client tags methods' do
  include_context 'Noko::Client'

  describe '#get_tags' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/tags").with(auth_header).to_return(json_array_response)

      expect(client.get_tags).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/tags?billable=true")

      client.get_tags(billable: true)
    end
  end

  describe '#create_tags' do
    it 'returns an array' do
      expect_request(:post, "#{base_url}/tags").with(json_request).to_return(json_array_response.merge(status: 201))

      expect(client.create_tags(%w[freckle])).to eq([])
    end
  end

  describe '#get_tag' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/tags/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_tag(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#get_tag_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/tags/#{id}/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_tag_entries(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/tags/#{id}/entries?billable=true")

      client.get_tag_entries(id, billable: true)
    end
  end

  describe '#update_tag' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/tags/#{id}").with(json_request).to_return(json_response)

      expect(client.update_tag(id, name: 'freckle')).to be_instance_of(Noko::Record)
    end
  end

  describe '#merge_tags' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/tags/#{id}/merge").with(json_request.merge(body: '{"tag_id":5678}')).to_return(status: 204)

      expect(client.merge_tags(id, 5678)).to eq(:no_content)
    end
  end

  describe '#delete_tag' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/tags/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_tag(id)).to eq(:no_content)
    end
  end

  describe '#delete_tags' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/tags/delete").with(json_request.merge(body: '{"tag_ids":[123]}')).to_return(status: 204)

      expect(client.delete_tags([id])).to eq(:no_content)
    end
  end
end
