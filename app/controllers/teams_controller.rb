class TeamsController < ApplicationController
  before_action :authenticate

  def invite
  @team = Team.new
  end

  def join
    if params[:team][:league_id].empty?
      flash[:notice] = "Invalid League ID"
      render :invite
    else @league = League.find(params[:team][:league_id])
      redirect_to new_league_team_path(@league)
    end
  end

  def new
    @team = Team.new
    @league = League.find(params[:league_id])
  end

  def create
    @team = Team.new(team_params)
    @team.user_id = current_user.id
    @team.league_id = params[:league_id]
    @league = League.find(params[:league_id])
    if @team.save
      flash[:notice] = "Team created"
      redirect_to league_team_path(@league, @team)
    else
      @errors = @team.errors.full_messages
      render :new
    end
  end

  def show
    @team = Team.find(params[:id])
    @league = League.find(@team.league_id)
    @roster = Roster.new()
    @team_lineup = []
    @team.rosters.each do |roster|
      if roster.position != "BN"
        @team_lineup << roster
      end
    end
    @team.rosters.each do |roster|
      if roster.position == "BN"
        @team_lineup << roster
      end
    end
  end

  def update
    binding.pry
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
