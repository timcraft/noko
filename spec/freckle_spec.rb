require 'minitest/autorun'
require 'webmock/minitest'
require 'freckle'

describe 'Freckle::Client' do
  before do
    @token = 'api_token'

    @user_agent = 'account.letsfreckle.com'

    @base_url = 'https://api.letsfreckle.com/v2'

    @entry_id = @project_id = @id = 1234

    @auth_header = {headers: {'X-FreckleToken' => @token}}

    @json_request = {headers: {'X-FreckleToken' => @token, 'Content-Type' => 'application/json'}, body: /\A{.+}\z/}

    @json_response = {headers: {'Content-Type' => 'application/json;charset=utf-8'}, body: '{}'}

    @client = Freckle::Client.new(token: @token, user_agent: @user_agent)
  end

  after do
    assert_requested(@request) if defined?(@request)
  end

  describe 'get_timers method' do
    it 'fetches the timers resource and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/timers").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_timers.must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/timers?billable=true")

      @client.get_timers(billable: true)
    end

    it 'encodes an array of ids into a single filter parameter' do
      @request = stub_request(:get, "#@base_url/timers?projects=4,5,6")

      @client.get_timers(projects: %w(4 5 6))
    end
  end

  describe 'get_timer method' do
    it 'fetches the timer resource with the given project id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/projects/#@project_id/timer").with(@auth_header).to_return(@json_response)

      @client.get_timer(@project_id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'update_timer method' do
    it 'updates the timer resource with the given project id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/projects/#@project_id/timer").with(@json_request).to_return(@json_response)

      @client.update_timer(@project_id, description: 'Notes go here').must_be_instance_of(Freckle::Record)
    end
  end

  describe 'start_timer method' do
    it 'sends a put request to the timer start resource with the given project id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/projects/#@project_id/timer/start").with(@auth_header).to_return(@json_response)

      @client.start_timer(@project_id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'pause_timer method' do
    it 'sends a put request to the timer pause resource with the given project id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/projects/#@project_id/timer/pause").with(@auth_header).to_return(@json_response)

      @client.pause_timer(@project_id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'log_timer method' do
    it 'sends a put request to the timer log resource with the given project id and returns a no content value' do
      @request = stub_request(:put, "#@base_url/projects/#@project_id/timer/log").with(@auth_header).to_return(status: 204)

      @client.log_timer(@project_id, description: 'Serious #development work').must_equal(:no_content)
    end
  end

  describe 'discard_timer method' do
    it 'deletes the timer resource with the given project id and returns a no content value' do
      @request = stub_request(:delete, "#@base_url/projects/#@project_id/timer").with(@auth_header).to_return(status: 204)

      @client.discard_timer(@project_id).must_equal(:no_content)
    end
  end

  describe 'get_entries method' do
    it 'fetches the entries resource and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/entries").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_entries.must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/entries?billable=true")

      @client.get_entries(billable: true)
    end

    it 'encodes an array of ids into a single filter parameter' do
      @request = stub_request(:get, "#@base_url/entries?project_ids=4,5,6")

      @client.get_entries(project_ids: %w(4 5 6))
    end
  end

  describe 'get_entry method' do
    it 'fetches the entry resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/entries/#@id").with(@auth_header).to_return(@json_response)

      @client.get_entry(@id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'create_entry method' do
    it 'posts the given attributes to the entries resource and returns the decoded response object' do
      @request = stub_request(:post, "#@base_url/entries").with(@json_request).to_return(@json_response.merge(status: 201))

      @client.create_entry(date: Date.today, minutes: 60).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'update_entry method' do
    it 'updates the entry resource with the given id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/entries/#@id").with(@json_request).to_return(@json_response)

      @client.update_entry(@id, minutes: 120).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'delete_entry method' do
    it 'deletes the entry resource with the given id' do
      @request = stub_request(:delete, "#@base_url/entries/#@id").with(@auth_header).to_return(status: 204)

      @client.delete_entry(@id)
    end
  end

  describe 'get_expenses method' do
    it 'fetches the expenses resource and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/expenses").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_expenses.must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/expenses?invoiced=true")

      @client.get_expenses(invoiced: true)
    end

    it 'encodes an array of ids into a single filter parameter' do
      @request = stub_request(:get, "#@base_url/expenses?project_ids=4,5,6")

      @client.get_expenses(project_ids: %w(4 5 6))
    end
  end

  describe 'get_expense method' do
    it 'fetches the expense resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/expenses/#@id").with(@auth_header).to_return(@json_response)

      @client.get_expense(@id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'create_expense method' do
    it 'posts the given attributes to the expenses resource and returns the decoded response object' do
      @request = stub_request(:post, "#@base_url/expenses").with(@json_request).to_return(@json_response.merge(status: 201))

      @client.create_expense(date: Date.today, project_id: @project_id, price: '14.55').must_be_instance_of(Freckle::Record)
    end
  end

  describe 'update_expense method' do
    it 'updates the expense resource with the given id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/expenses/#@id").with(@json_request).to_return(@json_response)

      @client.update_expense(@id, price: '19.99').must_be_instance_of(Freckle::Record)
    end
  end

  describe 'delete_expense method' do
    it 'deletes the expense resource with the given id' do
      @request = stub_request(:delete, "#@base_url/expenses/#@id").with(@auth_header).to_return(status: 204)

      @client.delete_expense(@id)
    end
  end

  describe 'get_account method' do
    it 'fetches the account resource and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/account").with(@auth_header).to_return(@json_response)

      @client.get_account
    end
  end

  it 'sets a next_page attribute on the response object for responses with rel next links' do
    @json_response[:body] = '[]'
    @json_response[:headers]['Link'] = '<https://api.letsfreckle.com/v2/entries?page=2>; rel="next"'

    @request = stub_request(:get, "#@base_url/entries").to_return(@json_response)

    @client.get_entries.next_page.must_equal('/v2/entries?page=2')
  end

  it 'supports authorization using an oauth access token instead of a personal access token' do
    @client = Freckle::Client.new(access_token: 'oauth2-access-token', user_agent: @user_agent)

    @request = stub_request(:get, "#@base_url/timers").with(headers: {'Authorization' => 'token oauth2-access-token'})

    @client.get_timers
  end

  it 'raises an exception for authentication errors' do
    @request = stub_request(:get, "#@base_url/timers").with(@auth_header).to_return(@json_response.merge(status: 401))

    proc { @client.get_timers }.must_raise(Freckle::AuthenticationError)
  end
end

describe 'Freckle::Record' do
  before do
    @record = Freckle::Record.new

    @record[:project_id] = 123
  end

  describe 'square brackets method' do
    it 'returns the value of the attribute with the given name' do
      @record[:project_id].must_equal(123)
    end
  end

  describe 'method_missing' do
    it 'returns the value of the attribute with the given name' do
      @record.project_id.must_equal(123)
    end
  end

  describe 'to_h method' do
    it 'returns a hash containing the record attributes' do
      @record.to_h.must_equal({project_id: 123})
    end
  end
end
