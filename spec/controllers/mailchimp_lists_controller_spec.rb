require 'rails_helper'

describe MailchimpListsController do
  describe "#index" do

    it 'returns mailchimp lists for valid credentials' do
      example_mailchimp_response = {
        "total"=> 2,
        "data"=> [
          {
            "id"   => "test1",
            "name" => "List 1"
          },
          {
            "id"   => "test2",
            "name"=>"List 2"
          }
        ]
      }

      allow_any_instance_of(Mailchimp::ApiClient).to receive(:lists).and_return(example_mailchimp_response)

      response = get :index, {datacenter: 'dc1', api_key: 'API_KEY'}, type: :json

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(example_mailchimp_response)
    end

    it 'returns 422 status for invalid credentials' do
      allow_any_instance_of(Mailchimp::ApiClient).to receive(:lists).and_raise(Exception)

      response = get :index, {datacenter: 'dc1', api_key: 'API_KEY'}, type: :json

      expect(response.status).to eq(422)
    end
  end
end
