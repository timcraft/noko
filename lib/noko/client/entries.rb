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

    def entries_invoiced_outside_of_freckle(attributes={})
      put('/v2/entries/invoiced_outside_of_freckle', attributes)
    end

     def entry_invoiced_outside_of_freckle(id, attributes)
      put("/v2/entries/#{id}/invoiced_outside_of_freckle", attributes)
    end
  end
end
