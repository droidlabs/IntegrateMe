class EntriesController < ApplicationController

  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      subscribe_to_mailchimp(@entry)
      render json: {success: true}
    else
      render json: {success: false, errors: @entry.errors}
    end
  end

  private
    def subscribe_to_mailchimp(entry)
      # Subscribe e-mail to mailchimp
      list_settings = Mailchimp::ListSettings.new(competition: entry.competition)
      if list_settings.valid?
        subscriber = Mailchimp::EmailSubscriber.new
        subscriber.subscribe_email(email: entry.email, list_settings: list_settings)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:competition_id, :name, :email)
    end
end
