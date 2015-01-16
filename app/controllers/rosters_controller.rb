class RostersController < ApplicationController
  before_action :authenticate

  def create
    roster = Roster.new()
    roster.position = params[:roster][:position]
    roster.team_id = params[:team_id]
    roster.player_id = params[:player_id]
    team = Team.find(roster.team_id)
    if roster.position == "BN"
      roster.status = "inactive"
    else
      roster.status = "active"
    end
    if roster.save
      flash[:notice] = "Lineup saved successfully."
    else
      flash[:notice] = "Uh-oh. Something is wrong. Leave feedback or come back later."
    end
    redirect_to league_team_path(team.league, team)
  end

  def destroy
    binding.pry
  end
end
