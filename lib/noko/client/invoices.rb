module Noko
  class Client
    def get_invoices(params = nil)
      get('/v2/invoices', params)
    end

    def get_invoice(id)
      get("/v2/invoices/#{id}")
    end

    def create_invoice(attributes)
      post('/v2/invoices', attributes)
    end

    def update_invoice(id, attributes)
      put("/v2/invoices/#{id}", attributes)
    end

    def mark_invoice_paid(id)
      put("/v2/invoices/#{id}/paid")
    end

    def mark_invoice_unpaid(id)
      put("/v2/invoices/#{id}/unpaid")
    end

    def get_invoice_entries(id, params = nil)
      get("/v2/invoices/#{id}/entries", params)
    end

    def get_invoice_expenses(id, params = nil)
      get("/v2/invoices/#{id}/expenses", params)
    end

    def delete_invoice(id)
      delete("/v2/invoices/#{id}")
    end
  end
end
