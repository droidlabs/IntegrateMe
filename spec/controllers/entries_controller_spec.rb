require "rails_helper"

def create_competition
   Competition.create(
    name: "Sample competition",
    requires_entry_name: false,
    mailchimp_api_key: "sample_key",
    mailchimp_list_id: "sample_list",
    mailchimp_datacenter: "us8"
  )
end

describe EntriesController do
  let(:competition) { create_competition }

  describe "#create" do
    before :each do
      allow(Mailchimp::ApiClient).to receive(:net_execute).and_return({}.to_json)
      post :create, entry: {competition_id: competition.id, email: "user@example.com"}
    end

    it "creates Entry" do
      expect(Entry.count).to eq(1)
      expect(Entry.last.email).to eq("user@example.com")
    end

    it "subscribes user" do
      expect(Mailchimp::ApiClient).to have_received(:net_execute)
    end
  end
end