require 'spec_helper'

RSpec.describe 'Noko::Client responses' do
  include_context 'Noko::Client'

  def response(headers)
    {headers: json_response_headers.merge(headers), body: '[]'}
  end

  describe '#rel_next_link' do
    it 'returns the rel=next link url' do
      link = '<https://api.nokotime.com/v2/entries?page=3>; rel="next"'

      expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

      expect(client.get_entries.link.next).to eq('/v2/entries?page=3')
    end
  end

  describe '#rel_prev_link' do
    it 'returns the rel=prev link url' do
      link = '<https://api.nokotime.com/v2/entries?page=2>; rel="prev"'

      expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

      expect(client.get_entries.link.prev).to eq('/v2/entries?page=2')
    end
  end

  describe '#rel_last_link' do
    it 'returns the rel=last link url' do
      link = '<https://api.nokotime.com/v2/entries?page=50>; rel="last"'

      expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

      expect(client.get_entries.link.last).to eq('/v2/entries?page=50')
    end
  end

  describe '#rel_first_link' do
    it 'returns the rel=first link url' do
      link = '<https://api.nokotime.com/v2/entries?page=1>; rel="first"'

      expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

      expect(client.get_entries.link.first).to eq('/v2/entries?page=1')
    end
  end
end
