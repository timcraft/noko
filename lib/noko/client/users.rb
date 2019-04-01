module Noko
  class Client
    def get_users(params = nil)
      get('/v2/users', params)
    end

    def get_user(id)
      get("/v2/users/#{id}")
    end

    def get_user_entries(id, params = nil)
      get("/v2/users/#{id}/entries", params)
    end

    def get_user_expenses(id, params = nil)
      get("/v2/users/#{id}/expenses", params)
    end

    def create_user(attributes)
      post('/v2/users', attributes)
    end

    def update_user(id, attributes)
      put("/v2/users/#{id}", attributes)
    end

    def delete_user(id)
      delete("/v2/users/#{id}")
    end

    def reactivate_user(id)
      put("/v2/users/#{id}/activate")
    end

    def deactivate_user(id)
      put("/v2/users/#{id}/deactivate")
    end
  end
end
