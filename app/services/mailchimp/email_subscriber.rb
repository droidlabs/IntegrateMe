class Mailchimp::EmailSubscriber
  def subscribe_email(email:, list_settings:)
    unless list_settings.is_a?(Mailchimp::ListSettings)
      raise ArgumentError, "'list_settings' should be instance of Mailchimp::ListSettings"
    end
    unless email.present?
      raise ArgumentError, "'email' can't be blank"
    end
    api_client.subscribe_to_list(
      list_id: list_settings.list_id,
      email: email,
      datacenter: list_settings.datacenter,
      api_key: list_settings.api_key
    )
  end

  def api_client
    @api_client ||= Mailchimp::ApiClient.new
  end
end
