# frozen_string_literal: true

class Noko::Client
  def get_account
    get('/v2/account')
  end
end
