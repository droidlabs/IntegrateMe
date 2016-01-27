class MailchimpListsController < ApplicationController
  # GET /mailchimp_lists.json
  def index
    response = mailchimp_client.lists(
      datacenter: params[:datacenter],
      api_key: params[:api_key]
    )
    render json: response.to_json
  rescue => e
    render json: {}, status: 422
  end

  private
    def mailchimp_client
      Mailchimp::ApiClient.new
    end
end
