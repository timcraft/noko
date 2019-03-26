module Noko
  class Client
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

    def get_project_expenses(id, params = nil)
      get("/v2/projects/#{id}/expenses", params)
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
