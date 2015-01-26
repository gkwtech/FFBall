class PlayersController < ApplicationController
  before_action :authenticate

  def index
    @league = League.find(params[:league_id])
    @team = current_user.teams.where(league_id: @league.id).first
    @unavailable_players = []
    @league.teams.each do |team|
      team.rosters.each do |roster|
        if roster.status == "member"
          @unavailable_players << roster.player_id
        end
      end
    end
    @available_players = Player.where.not(id: @unavailable_players, position: "")
    if params[:search]
      @available_players = @available_players.search(params[:search])
    end
    @available_players_list = Kaminari.paginate_array(@available_players).page(params[:page]).per(30)
    @roster = Roster.new
    render :index
  end

  def update
    @league = League.find(params[:league_id])
    current_user.teams.each do |team|
      if team.league_id == @league.id
        @team = team
      end
    end
    @player = Player.find(params[:id])
    @player.team_id = @team.id
    if @player.save
      flash[:notice] = "#{@player.first_name} #{@player.last_name} added"
      redirect_to league_team_path(@league, @team)
    else
      @error = "Uh-oh. Something is wrong. Leave feedback or come back later."
      render :index
    end
  end

  def drop
    roster = Roster.find_by(player_id: params[:player_id])
    player = Player.find(params[:player_id])
    team = Team.find(player.team_id)
    player.team_id = nil
    if roster.delete && player.save
      flash[:notice] = "Player Dropped."
    else
      flash[:notice] = "Uh-oh. Something is wrong. Leave feedback or come back later."
    end
    redirect_to league_team_path(team.league, team)
  end
end
