require 'faraday'
require 'json'

class Slack
  WEBHOOKS_URL = 'https://hooks.slack.com/services/YOUR_WEBHOOKS_URL_HERE'

  def message(text)
    conn = Faraday.new(:url => WEBHOOKS_URL) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    res = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = {
          :username => 'todoist',
          :text => text,
          :icon_emoji => ':slack:'
      }.to_json
    end
  end

end