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

    def entries_marked_as_invoiced(attributes={})
      put('/v2/entries/marked_as_invoiced', attributes)
    end

     def entry_marked_as_invoiced(id, attributes)
      put("/v2/entries/#{id}/marked_as_invoiced", attributes)
    end
  end
end
