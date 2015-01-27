class RostersController < ApplicationController
  before_action :authenticate

  def create
    roster = Roster.new()
    if params[:roster]
      roster.position = params[:roster][:position]
    else
      roster.position = "BN"
    end
    roster.team_id = params[:team_id]
    roster.player_id = params[:player_id]
    team = Team.find(roster.team_id)
    if roster.position == "BN"
      roster.status = "inactive"
    else
      roster.status = "active"
    end
    if roster.save && params[:roster]
      flash[:notice] = "Lineup saved successfully."
    elsif roster.save
      player = Player.find(roster.player_id)
      flash[:notice] = "#{player.first_name} #{player.last_name} added"
    else
      flash[:notice] = "Uh-oh. Something is wrong. Leave feedback or come back later."
    end
    redirect_to league_team_path(team.league, team)
  end

  def destroy
    roster = Roster.find(params[:id])
    @league = League.find(params[:league_id])
    @team = Team.find(params[:team_id])
    if roster.delete
      flash[:notice] = "Player Dropped."
    else
      flash[:notice] = "Uh-oh. Something is wrong. Leave feedback or come back later."
    end
    redirect_to league_team_path(@league, @team)
  end

  def update
    roster = Roster.find(params[:roster_id])
    @league = League.find(params[:league_id])
    @team = Team.find(params[:team_id])
    if roster.update(position: params[:roster][:position])
      flash[:notice] = "Lineup saved successfully."
      redirect_to league_team_path(@league, @team)
    else
      flash[:notice] = "Uh-oh. Something is wrong. Leave feedback or come back later."
      redirect_to league_team_path(@league, @team)
    end
  end

  def new
    # @league = League.find(params[:league_id])
    # @team = Team.find(params[:team_id])
    # @roster = Roster.new(team_id: @team.id, player_id: params[:player_id], status: "member", position: "BN")
    # if @roster.save
    #   flash[:notice] = "Player Added"
    #   redirect_to league_team_path(@league, @team)
    # else
    #   flash[:notice] = "Error"
    #   redirect_to league_team_path(@league, @team)
    # end
  end
end
