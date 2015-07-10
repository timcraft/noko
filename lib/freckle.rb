require 'freckle/client'

module Freckle
  class Client
    def get_timers(params = nil)
      get('/v2/timers', params)
    end

    def get_timer(project_id)
      get("/v2/projects/#{project_id}/timer")
    end

    def update_timer(project_id, attributes)
      put("/v2/projects/#{project_id}/timer", attributes)
    end

    def start_timer(project_id)
      put("/v2/projects/#{project_id}/timer/start")
    end

    def pause_timer(project_id)
      put("/v2/projects/#{project_id}/timer/pause")
    end

    def log_timer(project_id, attributes = {})
      put("/v2/projects/#{project_id}/timer/log", attributes)
    end

    def discard_timer(project_id)
      delete("/v2/projects/#{project_id}/timer")
    end

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
  end
end
