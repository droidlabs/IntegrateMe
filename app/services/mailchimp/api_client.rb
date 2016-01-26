require 'net/http'

class Mailchimp::ApiClient
  SITE_URL                  = 'https://%{dc}.api.mailchimp.com/2.0/'
  SUBSCRIBE_TO_LIST_URL     = SITE_URL + "/lists/subscribe.json"
  LIST_ALL_LISTS_URL        = SITE_URL + "/lists/list.json"

  def subscribe_to_list(list_id:, email:, datacenter:, api_key:)
    url = SUBSCRIBE_TO_LIST_URL % { dc: datacenter }
    json = net_execute(:post, url,
      apikey:          api_key,
      id:              list_id,
      email:           { email: email },
      update_existing: true,
      double_optin:    false,
      merge_vars:      {}
    )
    parse_json(json)
  end

  def lists(datacenter:, api_key:)
    url = LIST_ALL_LISTS_URL % { dc: datacenter } + "?apikey=#{api_key}"
    json = net_execute(:get, url, api_key: api_key)
    parse_json(json)
  end

  private
    def net_execute(method, url, params)
      self.class.net_execute(method, url, params)
    end

    # We are using RestClient::Request instead RestClient.get
    # to avoid issues with SSL certs while testing this demo on osx computers
    def self.net_execute(method, url, params)
      if method == :get
        RestClient::Request.execute(method: :get, url: url, payload: params, verify_ssl: false)
      else
        RestClient::Request.execute(method: method, url: url, payload: params, verify_ssl: false)
      end
    end

    def parse_json(json)
      JSON.parse(json)
    end
end
