class MailchimpListsController < ApplicationController
  # GET /mailchimp_lists.json
  def index
    response = mailchimp_client.lists(
      datacenter: params[:datacenter],
      api_key: params[:api_key]
    )
    render json: response.to_json
  end

  private
    def mailchimp_client
      Mailchimp::ApiClient.new
    end
end
