class DraftsController < ApplicationController
  before_action :authenticate, :commissioner_authenticate
  def index
    binding.pry
  end
  def show
    binding.pry
    @pick = Pick.new
  end
  def new
    @league = League.find(params[:league_id])
    if @league.teams.count < @league.member_amount.to_i
      flash[:notice] = "Your league is not full yet and cannot draft"
      redirect_to league_path(@league)
    else
      @draft = Draft.new
      render :new, layout: false
    end
  end
  def create
    @league = League.find(params[:league_id])
    member_amount = @league.teams.count
    @teams = []
    until member_amount == 0
      @teams << Team.find(params["team_id-#{member_amount}"])
      member_amount -= 1
    end
    @teams.reverse!
    @players = Player.all
    @draft = Draft.new(league_id: @league.id)
    if @draft.save
      @pick = Pick.new(number: 1)
      @round = Round.new(number: 1, draft_id: @draft.id)
      @round.save
      @team_lineups = {}
      @teams.each do |team|
        @team_lineups[team.id] = team.project_lineup
      end
      render :show, layout: false
    else
      flash[:notice] = "Something went wrong. Leave feedback or try again later."
      redirect_to league_path(@league)
    end
  end
end
