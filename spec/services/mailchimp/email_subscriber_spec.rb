require "rails_helper"

def build_settings
  list_settings = Mailchimp::ListSettings.new
  list_settings.datacenter = "us8"
  list_settings.api_key = "sample_key"
  list_settings.list_id = "list_7788"
  list_settings
end

describe Mailchimp::EmailSubscriber do
  subject { Mailchimp::EmailSubscriber.new }
  let(:list_settings) { build_settings }

  describe "#subscribe_email" do
    it "subscribes email to mailchimp within list_settings settings" do
      expect(subject.api_client).to receive(:subscribe_to_list).with(
        list_id: "list_7788",
        email: "user@example.com",
        datacenter: "us8",
        api_key: "sample_key"
      )

      subject.subscribe_email(email: "user@example.com", list_settings: list_settings)
    end
  end
end