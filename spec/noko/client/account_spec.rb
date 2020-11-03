require 'spec_helper'

RSpec.describe 'Noko::Client account methods' do
  include_context 'Noko::Client'

  describe '#get_account' do
    it 'returns a record' do
      expect_request(:get, "#{base_url}/account").with(auth_header).to_return(json_response)

      expect(client.get_account).to be_a(Noko::Record)
    end
  end
end
