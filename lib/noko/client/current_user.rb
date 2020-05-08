# frozen_string_literal: true

module Noko
  class Client
    def get_current_user
      get('/v2/current_user')
    end

    def get_current_user_entries(params = nil)
      get('/v2/current_user/entries', params)
    end

    def get_current_user_expenses(params = nil)
      get('/v2/current_user/expenses', params)
    end

    def update_current_user(attributes)
      put('/v2/current_user', attributes)
    end
  end
end
