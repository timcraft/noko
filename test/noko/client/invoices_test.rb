require_relative '../client_test'

class ClientInvoicesTest < ClientTest
  def test_get_invoices
    expect_request(:get, "#{base_url}/invoices").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_invoices
  end

  def test_get_invoices_encodes_params
    expect_request(:get, "#{base_url}/invoices?state=unpaid")

    client.get_invoices(state: :unpaid)
  end

  def test_get_invoice
    expect_request(:get, "#{base_url}/invoices/#{id}").with(auth_header).to_return(json_response)

    assert_instance_of Noko::Record, client.get_invoice(id)
  end

  def test_create_invoice
    expect_request(:post, "#{base_url}/invoices").with(json_request).to_return(json_response.merge(status: 201))

    assert_instance_of Noko::Record, client.create_invoice(invoice_date: Date.today)
  end

  def test_update_invoice
    expect_request(:put, "#{base_url}/invoices/#{id}").with(json_request).to_return(json_response)

    assert_instance_of Noko::Record, client.update_invoice(id, reference: 'AB 0001')
  end

  def test_mark_invoice_paid
    expect_request(:put, "#{base_url}/invoices/#{id}/paid").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.mark_invoice_paid(id)
  end

  def test_mark_invoice_unpaid
    expect_request(:put, "#{base_url}/invoices/#{id}/unpaid").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.mark_invoice_unpaid(id)
  end

  def test_get_invoice_entries
    expect_request(:get, "#{base_url}/invoices/#{id}/entries").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_invoice_entries(id)
  end

  def test_get_invoice_entries_encodes_params
    expect_request(:get, "#{base_url}/invoices/#{id}/entries?billable=true")

    client.get_invoice_entries(id, billable: true)
  end

  def test_get_invoice_expenses
    expect_request(:get, "#{base_url}/invoices/#{id}/expenses").with(auth_header).to_return(json_array_response)

    assert_equal [], client.get_invoice_expenses(id)
  end

  def test_get_invoice_expenses_encodes_params
    expect_request(:get, "#{base_url}/invoices/#{id}/expenses?invoiced=false")

    client.get_invoice_expenses(id, invoiced: false)
  end

  def test_delete_invoice
    expect_request(:delete, "#{base_url}/invoices/#{id}").with(auth_header).to_return(status: 204)

    assert_equal :no_content, client.delete_invoice(id)
  end
end
