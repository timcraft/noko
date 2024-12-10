# frozen_string_literal: true

class Noko::Client
  def get_teams(params = nil)
    get('/v2/teams', params)
  end

  def get_team(id)
    get("/v2/teams/#{id}")
  end

  def create_team(attributes)
    post('/v2/teams', attributes)
  end

  def update_team(id, attributes)
    put("/v2/teams/#{id}", attributes)
  end

  def get_team_entries(id, params = nil)
    get("/v2/teams/#{id}/entries", params)
  end

  def get_team_users(id, params = nil)
    get("/v2/teams/#{id}/users", params)
  end

  def add_team_users(id, params)
    post("/v2/teams/#{id}/add_users", params)
  end

  def remove_team_users(id, params)
    put("/v2/teams/#{id}/remove_users", params)
  end

  def remove_all_team_users(id)
    put("/v2/teams/#{id}/remove_all_users")
  end

  def delete_team(id)
    delete("/v2/teams/#{id}")
  end
end
