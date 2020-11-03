require 'spec_helper'

RSpec.describe 'Noko::Client invoices methods' do
  include_context 'Noko::Client'

  describe '#get_invoices' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/invoices").with(auth_header).to_return(json_array_response)

      expect(client.get_invoices).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/invoices?state=unpaid")

      client.get_invoices(state: :unpaid)
    end
  end

  describe '#get_invoice' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/invoices/#{id}").with(auth_header).to_return(json_response)

      expect(client.get_invoice(id)).to be_instance_of(Noko::Record)
    end
  end

  describe '#create_invoice' do
    it 'returns a record' do
      expect_request(:post, "#{base_url}/invoices").with(json_request).to_return(json_response.merge(status: 201))

      expect(client.create_invoice(invoice_date: Date.today)).to be_instance_of(Noko::Record)
    end
  end

  describe '#update_invoice' do
    it 'returns a record' do
      expect_request(:put, "#{base_url}/invoices/#{id}").with(json_request).to_return(json_response)

      expect(client.update_invoice(id, reference: 'AB 0001')).to be_instance_of(Noko::Record)
    end
  end

  describe '#mark_invoice_paid' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/invoices/#{id}/paid").with(auth_header).to_return(status: 204)

      expect(client.mark_invoice_paid(id)).to eq(:no_content)
    end
  end

  describe '#mark_invoice_unpaid' do
    it 'returns :no_content' do
      expect_request(:put, "#{base_url}/invoices/#{id}/unpaid").with(auth_header).to_return(status: 204)

      expect(client.mark_invoice_unpaid(id)).to eq(:no_content)
    end
  end

  describe '#get_invoice_entries' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/invoices/#{id}/entries").with(auth_header).to_return(json_array_response)

      expect(client.get_invoice_entries(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/invoices/#{id}/entries?billable=true")

      client.get_invoice_entries(id, billable: true)
    end
  end

  describe '#get_invoice_expenses' do
    it 'returns an array' do
      expect_request(:get, "#{base_url}/invoices/#{id}/expenses").with(auth_header).to_return(json_array_response)

      expect(client.get_invoice_expenses(id)).to eq([])
    end

    it 'encodes params' do
      expect_request(:get, "#{base_url}/invoices/#{id}/expenses?invoiced=false")

      client.get_invoice_expenses(id, invoiced: false)
    end
  end

  describe '#delete_invoice' do
    it 'returns :no_content' do
      expect_request(:delete, "#{base_url}/invoices/#{id}").with(auth_header).to_return(status: 204)

      expect(client.delete_invoice(id)).to eq(:no_content)
    end
  end
end
