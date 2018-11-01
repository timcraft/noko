module Freckle
  class Client
    def get_account
      get('/v2/account')
    end
  end
end
