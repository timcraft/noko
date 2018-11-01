module Freckle
  class Client
    def get_expenses(params = nil)
      get('/v2/expenses', params)
    end

    def get_expense(id)
      get("/v2/expenses/#{id}")
    end

    def create_expense(attributes)
      post('/v2/expenses', attributes)
    end

    def update_expense(id, attributes)
      put("/v2/expenses/#{id}", attributes)
    end

    def delete_expense(id)
      delete("/v2/expenses/#{id}")
    end
  end
end
