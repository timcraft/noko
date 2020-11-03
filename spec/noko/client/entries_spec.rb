require 'spec_helper'

RSpec.describe 'Noko::Client entries methods' do
  include_context 'Noko::Client'

  let(:time) { Time.now.utc }
  let(:date) { Date.parse('2019-03-04') }

  describe '#get_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_entries).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/entries?billable=true")

      client.get_entries(billable: true)
    end

    it 'encodes ids' do
      expect_request(:get, "#{base_url}/entries?project_ids=123,456,789")

      client.get_entries(project_ids: ids)
    end
  end

  describe '#get_entry' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/entries/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_entry(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#create_entry' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/entries").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_entry(date: Date.today, minutes: 60)).to be_instance_of(Noko::Record)
    end
  end

  describe '#update_entry' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/entries/#{id}").with(json_request).to_return(json_response)

      expect(client.update_entry(id, minutes: 120)).to be_instance_of(Noko::Record)
    end
  end

  describe '#delete_entry' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/entries/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_entry(id)).to eq(:no_content)
    end
  end

  describe '#mark_entry_invoiced' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/entries/#{id}/marked_as_invoiced").with(json_request).to_return(status: 204)

      expect(client.mark_entry_invoiced(id, date: date)).to eq(:no_content)
    end
  end

  describe '#mark_entries_invoiced' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/entries/marked_as_invoiced").with(json_request).to_return(status: 204)

      expect(client.mark_entries_invoiced(entry_ids: ids, date: date)).to eq(:no_content)
    end
  end

  describe '#mark_entry_approved' do
    it 'returns :no_content' do
      body = /\A{"approved_at":"\d{4}\-\d{2}\-\d{2}T\d{2}:\d{2}:\d{2}Z"}\z/

      json_request = {headers: {'X-NokoToken' => token, 'Content-Type' => 'application/json'}, body: body}

      expect_request(:put, "#{base_url}/entries/#{id}/approved").with(json_request).to_return(status: 204)

      expect(client.mark_entry_approved(id, approved_at: time.iso8601)).to eq(:no_content)
    end
  end

  describe '#mark_entries_approved' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/entries/approved").with(json_request).to_return(status: 204)

      expect(client.mark_entries_approved(entry_ids: ids, approved_at: time)).to eq(:no_content)
    end
  end

  describe '#mark_entry_unapproved' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/entries/#{id}/unapproved").with(headers: {'X-NokoToken' => token}).to_return(status: 204)

      expect(client.mark_entry_unapproved(id)).to eq(:no_content)
    end
  end

  describe '#mark_entries_unapproved' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/entries/unapproved").with(json_request).to_return(status: 204)

      expect(client.mark_entries_unapproved(entry_ids: ids)).to eq(:no_content)
    end
  end
end
