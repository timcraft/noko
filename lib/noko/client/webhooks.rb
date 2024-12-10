class Noko::Client
  def get_webhooks(params = nil)
    get('/v2/webhooks', params)
  end

  def get_webhook(id)
    get("/v2/webhooks/#{id}")
  end

  def create_webhook(attributes)
    post('/v2/webhooks', attributes)
  end

  def update_webhook(id, attributes)
    put("/v2/webhooks/#{id}", attributes)
  end

  def add_webhook_events(id, attributes)
    put("/v2/webhooks/#{id}/add_events", attributes)
  end

  def remove_webhook_events(id, attributes)
    put("/v2/webhooks/#{id}/remove_events", attributes)
  end

  def reroll_webhook_secret(id)
    put("/v2/webhooks/#{id}/reroll_secret")
  end

  def disable_webhook(id)
    put("/v2/webhooks/#{id}/disable")
  end

  def enable_webhook(id)
    put("/v2/webhooks/#{id}/enable")
  end

  def delete_webhook(id)
    delete("/v2/webhooks/#{id}")
  end
end
