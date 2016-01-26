class AddMailchimpDetailsToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :mailchimp_datacenter, :string, limit: 50, default: ""
    add_column :competitions, :mailchimp_api_key, :string, limit: 50, default: ""
    add_column :competitions, :mailchimp_list_id, :string, limit: 50, default: ""
  end
end
