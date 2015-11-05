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

    def get_account
      get('/v2/account')
    end

    def get_tags(params = nil)
      get('/v2/tags', params)
    end

    def create_tags(names)
      post('/v2/tags', names: names)
    end

    def get_tag(id)
      get("/v2/tags/#{id}")
    end

    def get_tag_entries(id, params = nil)
      get("/v2/tags/#{id}/entries", params)
    end

    def update_tag(id, attributes)
      put("/v2/tags/#{id}", attributes)
    end

    def merge_tags(id, tag_id)
      put("/v2/tags/#{id}/merge", tag_id: tag_id)
    end

    def delete_tag(id)
      delete("/v2/tags/#{id}")
    end

    def delete_tags(tag_ids)
      put('/v2/tags/delete', tag_ids: tag_ids)
    end

    def get_projects(params = nil)
      get('/v2/projects', params)
    end

    def get_project(id)
      get("/v2/projects/#{id}")
    end

    def create_project(attributes)
      post('/v2/projects', attributes)
    end

    def get_project_entries(id, params = nil)
      get("/v2/projects/#{id}/entries", params)
    end

    def get_project_invoices(id, params = nil)
      get("/v2/projects/#{id}/invoices", params)
    end

    def get_project_participants(id, params = nil)
      get("/v2/projects/#{id}/participants", params)
    end

    def update_project(id, attributes)
      put("/v2/projects/#{id}", attributes)
    end

    def merge_projects(id, project_id)
      put("/v2/projects/#{id}/merge", project_id: project_id)
    end

    def delete_project(id)
      delete("/v2/projects/#{id}")
    end

    def archive_project(id)
      put("/v2/projects/#{id}/archive")
    end

    def unarchive_project(id)
      put("/v2/projects/#{id}/unarchive")
    end

    def archive_projects(project_ids)
      put('/v2/projects/archive', project_ids: project_ids)
    end

    def unarchive_projects(project_ids)
      put('/v2/projects/unarchive', project_ids: project_ids)
    end

    def delete_projects(project_ids)
      put('/v2/projects/delete', project_ids: project_ids)
    end
  end
end
