class CompetitionsController < ApplicationController
  # PATCH /competitions/:id.json
  def update
    competition = Competition.find(params[:id])
    if competition.update_attributes(competition_update_params)
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  def entrant_page
    @entry = Entry.new(competition: Competition.find(params[:competition_id]))
  end

  def edit
    @competition = Competition.find(params[:id])
  end

  private
    def competition_update_params
      params.require(:competition).permit(:mailchimp_api_key, :mailchimp_list_id, :mailchimp_datacenter)
    end
end