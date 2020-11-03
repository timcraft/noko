require 'spec_helper'

RSpec.describe 'Noko::Client' do
  include_context 'Noko::Client'

  context 'with a bad request error' do
    it 'raises an exception' do
      message = 'The Project cannot be deleted because it has entries, expenses, or invoices.'

      response = json_response.merge(status: 400, body: %({"message":"#{message}"}))

      stub_request(:delete, "#{base_url}/projects/#{id}").to_return(response)

      expect { client.delete_project(id) }.to raise_error(Noko::Error) { |exception|
        expect(exception.message).to include(message)
      }
    end
  end

  describe 'with an authentication error' do
    it 'raises an exception' do
      response = json_response.merge(status: 401)

      stub_request(:get, "#{base_url}/entries").to_return(response)

      expect { client.get_entries }.to raise_error(Noko::AuthenticationError)
    end
  end
end
