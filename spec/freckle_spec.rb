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

  describe 'get_tags method' do
    it 'fetches the tags resource and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/tags").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_tags.must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/tags?billable=true")

      @client.get_tags(billable: true)
    end
  end

  describe 'create_tags method' do
    it 'posts the given namaes to the tags resource and returns the decoded response object' do
      @request = stub_request(:post, "#@base_url/tags").with(@json_request).to_return(@json_response.merge(status: 201, body: '[]'))

      @client.create_tags(%w(freckle)).must_equal([])
    end
  end

  describe 'get_tag method' do
    it 'fetches the tag resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/tags/#@id").with(@auth_header).to_return(@json_response)

      @client.get_tag(@id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'get_tag_entries method' do
    it 'fetches the tag entries resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/tags/#@id/entries").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_tag_entries(@id).must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/tags/#@id/entries?billable=true")

      @client.get_tag_entries(@id, billable: true)
    end
  end

  describe 'update_tag method' do
    it 'updates the tag resource with the given id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/tags/#@id").with(@json_request).to_return(@json_response)

      @client.update_tag(@id, name: 'freckle').must_be_instance_of(Freckle::Record)
    end
  end

  describe 'merge_tags method' do
    it 'updates the tag merge resource with the given id and tag id' do
      @request = stub_request(:put, "#@base_url/tags/#@id/merge").with(@json_request.merge(body: '{"tag_id":5678}')).to_return(status: 204)

      @client.merge_tags(@id, 5678)
    end
  end

  describe 'delete_tag method' do
    it 'deletes the tag resource with the given id' do
      @request = stub_request(:delete, "#@base_url/tags/#@id").with(@auth_header).to_return(status: 204)

      @client.delete_tag(@id)
    end
  end

  describe 'delete_tags method' do
    it 'updates the tags delete resource with the given tag ids' do
      @request = stub_request(:put, "#@base_url/tags/delete").with(@json_request.merge(body: '{"tag_ids":[1234]}')).to_return(status: 204)

      @client.delete_tags([@id])
    end
  end

  describe 'get_projects method' do
    it 'fetches the projects resource and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/projects").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_projects.must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/projects?billable=true")

      @client.get_projects(billable: true)
    end
  end

  describe 'get_project method' do
    it 'fetches the project resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/projects/#@id").with(@auth_header).to_return(@json_response)

      @client.get_project(@id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'create_project method' do
    it 'posts the given attributes to the projects resource and returns the decoded response object' do
      @request = stub_request(:post, "#@base_url/projects").with(@json_request).to_return(@json_response.merge(status: 201))

      @client.create_project(name: 'Gear GmbH').must_be_instance_of(Freckle::Record)
    end
  end

  describe 'get_project_entries method' do
    it 'fetches the project entries resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/projects/#@id/entries").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_project_entries(@id).must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/projects/#@id/entries?billable=true")

      @client.get_project_entries(@id, billable: true)
    end
  end

  describe 'get_project_invoices method' do
    it 'fetches the project invoices resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/projects/#@id/invoices").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_project_invoices(@id).must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/projects/#@id/invoices?state=awaiting_payment")

      @client.get_project_invoices(@id, state: :awaiting_payment)
    end
  end

  describe 'get_project_participants method' do
    it 'fetches the project participants resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/projects/#@id/participants").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_project_participants(@id).must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/projects/#@id/participants?role=freelancer")

      @client.get_project_participants(@id, role: :freelancer)
    end
  end

  describe 'update_project method' do
    it 'updates the project resource with the given id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/projects/#@id").with(@json_request).to_return(@json_response)

      @client.update_project(@id, color: '#ff9898').must_be_instance_of(Freckle::Record)
    end
  end

  describe 'merge_projects method' do
    it 'updates the project merge resource with the given id and project id' do
      @request = stub_request(:put, "#@base_url/projects/#@id/merge").with(@json_request.merge(body: '{"project_id":5678}')).to_return(status: 204)

      @client.merge_projects(@id, 5678)
    end
  end

  describe 'delete_project method' do
    it 'deletes the project resource with the given id' do
      @request = stub_request(:delete, "#@base_url/projects/#@id").with(@auth_header).to_return(status: 204)

      @client.delete_project(@id)
    end
  end

  describe 'archive_project method' do
    it 'updates the project archive resource with the given id' do
      @request = stub_request(:put, "#@base_url/projects/#@id/archive").with(@auth_header).to_return(status: 204)

      @client.archive_project(@id)
    end
  end

  describe 'unarchive_project method' do
    it 'updates the project unarchive resource with the given id' do
      @request = stub_request(:put, "#@base_url/projects/#@id/unarchive").with(@auth_header).to_return(status: 204)

      @client.unarchive_project(@id)
    end
  end

  describe 'archive_projects method' do
    it 'updates the projects archive resource with the given project ids' do
      @request = stub_request(:put, "#@base_url/projects/archive").with(@json_request.merge(body: '{"project_ids":[1234]}')).to_return(status: 204)

      @client.archive_projects([@id])
    end
  end

  describe 'unarchive_projects method' do
    it 'updates the projects unarchive resource with the given project ids' do
      @request = stub_request(:put, "#@base_url/projects/unarchive").with(@json_request.merge(body: '{"project_ids":[1234]}')).to_return(status: 204)

      @client.unarchive_projects([@id])
    end
  end

  describe 'delete_projects method' do
    it 'updates the projects delete resource with the given project ids' do
      @request = stub_request(:put, "#@base_url/projects/delete").with(@json_request.merge(body: '{"project_ids":[1234]}')).to_return(status: 204)

      @client.delete_projects([@id])
    end
  end

  describe 'get_invoices method' do
    it 'fetches the invoices resource and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/invoices").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_invoices.must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/invoices?state=unpaid")

      @client.get_invoices(state: :unpaid)
    end
  end

  describe 'get_invoice method' do
    it 'fetches the invoice resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/invoices/#@id").with(@auth_header).to_return(@json_response)

      @client.get_invoice(@id).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'create_invoice method' do
    it 'posts the given attributes to the invoices resource and returns the decoded response object' do
      @request = stub_request(:post, "#@base_url/invoices").with(@json_request).to_return(@json_response.merge(status: 201))

      @client.create_invoice(invoice_date: Date.today).must_be_instance_of(Freckle::Record)
    end
  end

  describe 'update_invoice method' do
    it 'updates the invoice resource with the given id and returns the decoded response object' do
      @request = stub_request(:put, "#@base_url/invoices/#@id").with(@json_request).to_return(@json_response)

      @client.update_invoice(@id, reference: 'AB 0001').must_be_instance_of(Freckle::Record)
    end
  end

  describe 'mark_invoice_paid method' do
    it 'updates the invoice paid resource with the given id' do
      @request = stub_request(:put, "#@base_url/invoices/#@id/paid").with(@auth_header).to_return(status: 204)

      @client.mark_invoice_paid(@id)
    end
  end

  describe 'mark_invoice_unpaid method' do
    it 'updates the invoice unpaid resource with the given id' do
      @request = stub_request(:put, "#@base_url/invoices/#@id/unpaid").with(@auth_header).to_return(status: 204)

      @client.mark_invoice_unpaid(@id)
    end
  end

  describe 'get_invoice_entries method' do
    it 'fetches the invoice entries resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/invoices/#@id/entries").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_invoice_entries(@id).must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/invoices/#@id/entries?billable=true")

      @client.get_invoice_entries(@id, billable: true)
    end
  end

  describe 'get_invoice_expenses method' do
    it 'fetches the invoice expenses resource with the given id and returns the decoded response object' do
      @request = stub_request(:get, "#@base_url/invoices/#@id/expenses").with(@auth_header).to_return(@json_response.merge(body: '[]'))

      @client.get_invoice_expenses(@id).must_equal([])
    end

    it 'encodes optional filter parameters' do
      @request = stub_request(:get, "#@base_url/invoices/#@id/expenses?invoiced=false")

      @client.get_invoice_expenses(@id, invoiced: false)
    end
  end

  describe 'delete_invoice method' do
    it 'deletes the invoice resource with the given id' do
      @request = stub_request(:delete, "#@base_url/invoices/#@id").with(@auth_header).to_return(status: 204)

      @client.delete_invoice(@id)
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

  it 'raises an exception with the server error message for bad request errors' do
    message = 'The Project cannot be deleted because it has entries, expenses, or invoices.'

    stub_request(:delete, "#@base_url/projects/#@id").to_return(@json_response.merge(status: 400, body: %({"message":"#{message}"})))

    exception = proc { @client.delete_project(@id) }.must_raise(Freckle::Error)

    exception.message.must_include(message)
  end

  it 'raises an exception for authentication errors' do
    stub_request(:get, "#@base_url/timers").to_return(@json_response.merge(status: 401))

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
