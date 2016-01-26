class Mailchimp::ListSettings
  attr_accessor :datacenter, :api_key, :list_id

  def initialize(competition: nil)
    if competition
      @datacenter = competition.mailchimp_datacenter
      @api_key    = competition.mailchimp_api_ket
      @list_id    = competition.mailchimp_list_id
    end
  end
end
