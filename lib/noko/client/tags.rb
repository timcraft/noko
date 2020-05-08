# frozen_string_literal: true

module Noko
  class Client
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
  end
end
