module Noko
  class Client
    def get_entries(params = nil)
      get('/v2/entries', params)
    end

    def get_entry(id)
      get("/v2/entries/#{id}")
    end

    def create_entry(attributes)
      post('/v2/entries', attributes)
    end

    def update_entry(id, attributes)
      put("/v2/entries/#{id}", attributes)
    end

    def delete_entry(id)
      delete("/v2/entries/#{id}")
    end

    def mark_entry_invoiced(id, params)
      put("/v2/entries/#{id}/marked_as_invoiced", params)
    end

    def mark_entries_invoiced(params)
      put('/v2/entries/marked_as_invoiced', params)
    end

    def mark_entry_approved(id, params = nil)
      put("/v2/entries/#{id}/approved", params)
    end

    def mark_entries_approved(params)
      put('/v2/entries/approved', params)
    end
  end
end
