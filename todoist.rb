require 'faraday'
require 'json'

class Todoist

  API_ENDPOINT = 'https://todoist.com/API/v6/'
  TOKEN = 'YOUR TOKEN HERE'

  def get_tasks

    conn = Faraday.new(:url => API_ENDPOINT) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    res = conn.post do |req|
      req.url 'sync'
      req.body = {
          :token => TOKEN,
          :seq_no => 0,
          :resource_types => '["items"]'
      }
    end

    JSON.parse(res.body)
  end

end