module Freckle
  class Client
    def get_project_groups(params = nil)
      get('/v2/project_groups', params)
    end

    def get_project_group(id)
      get("/v2/project_groups/#{id}")
    end

    def create_project_group(attributes)
      post('/v2/project_groups', attributes)
    end

    def get_project_group_entries(id, params = nil)
      get("/v2/project_groups/#{id}/entries", params)
    end

    def get_project_group_projects(id, params = nil)
      get("/v2/project_groups/#{id}/projects", params)
    end

    def update_project_group(id, attributes)
      put("/v2/project_groups/#{id}", attributes)
    end

    def delete_project_group(id)
      delete("/v2/project_groups/#{id}")
    end
  end
end
