require 'spec_helper'

RSpec.describe 'Noko::Client expenses methods' do
  include_context 'Noko::Client'

  describe '#get_expenses' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/expenses").with(auth_header).to_return(json_array_response)

      expect(client.get_expenses).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/expenses?invoiced=true")

      client.get_expenses(invoiced: true)
    end

    it 'encodes ids' do
      expect_request(:get, "#{base_url}/expenses?project_ids=123,456,789")

      client.get_expenses(project_ids: ids)
    end
  end

  describe '#get_expense' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/expenses/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_expense(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#create_expense' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/expenses").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_expense(date: Date.today, project_id: id, price: '14.55')).to be_instance_of(Noko::Record)
    end
  end

  describe '#update_expense' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/expenses/#{id}").with(json_request).to_return(json_response)

      expect(client.update_expense(id, price: '19.99')).to be_instance_of(Noko::Record)
    end
  end

  describe '#delete_expense' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/expenses/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_expense(id)).to eq(:no_content)
    end
  end
end
