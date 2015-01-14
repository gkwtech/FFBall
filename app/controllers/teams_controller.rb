class TeamsController < ApplicationController
  before_action :authenticate

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
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
