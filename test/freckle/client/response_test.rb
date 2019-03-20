require_relative '../client_test'

class FreckleClientResponseTest < FreckleClientTest
  def response(headers)
    {headers: json_response_headers.merge(headers), body: '[]'}
  end

  def test_rel_next_link
    link = '<https://api.nokotime.com/v2/entries?page=3>; rel="next"'

    expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

    assert_equal '/v2/entries?page=3', client.get_entries.link.next
  end

  def test_rel_prev_link
    link = '<https://api.nokotime.com/v2/entries?page=2>; rel="prev"'

    expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

    assert_equal '/v2/entries?page=2', client.get_entries.link.prev
  end

  def test_rel_last_link
    link = '<https://api.nokotime.com/v2/entries?page=50>; rel="last"'

    expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

    assert_equal '/v2/entries?page=50', client.get_entries.link.last
  end

  def test_rel_first_link
    link = '<https://api.nokotime.com/v2/entries?page=1>; rel="first"'

    expect_request(:get, "#{base_url}/entries").to_return(response('Link' => link))

    assert_equal '/v2/entries?page=1', client.get_entries.link.first
  end
end
