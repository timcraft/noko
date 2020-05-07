module Noko
  class Client
    def get_webhooks(params = nil)
      get('/v2/webhooks', params)
    end
  end
end
