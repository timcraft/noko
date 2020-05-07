module Noko
  class Client
    def get_webhooks(params = nil)
      get('/v2/webhooks', params)
    end

    def get_webhook(id)
      get("/v2/webhooks/#{id}")
    end

    def create_webhook(attributes)
      post('/v2/webhooks', attributes)
    end
  end
end
