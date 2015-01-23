class PicksController < ApplicationController
  before_action :authenticate, :commissioner_authenticate
  def new
    binding.pry
  end
  def create
    @league = League.find(params[:league_id])
    @draft = Draft.find(params[:draft_id])
    @round = Round.find(params[:round_id])
    pick = Pick.new(
      price: params[:pick][:price],
      player_id: params[:player_id],
      round_id: params[:round_id],
      team_id: params[:pick][:team_id][1],
      number: params[:pick][:number]
      )
    @teams = []
    i = 0
    member_amount = params[:team_order].count
    until member_amount == 0
      @teams << Team.find(params[:team_order][i.to_s])
      i += 1
      member_amount -= 1
    end
    @drafting_team = Team.find(params[:pick][:team_id][1])
    @drafting_team_roster = @drafting_team.rosters.new(
      player_id: pick.player_id,
      status: "member")
    @drafted_player = Player.find(params[:player_id])
    if @drafting_team.active_roster_count < @league.max_players && pick.save && @drafting_team_roster.save
      @teams.rotate!
      @pick_history = []
      @draft.rounds.each do |round|
        @pick_history << round.picks
      end
      @pick_history.flatten!
      @drafted_player_ids = @pick_history.map {
        |pick| pick.player_id
      }
      number_of_rounds = @draft.rounds.count
      number_of_picks = @pick_history.count
      current_round_picks = (number_of_rounds * @league.teams.count) - number_of_picks
      total_rounds = (@teams.count * @league.max_players) / @draft.rounds.count
      if current_round_picks == 0
        if @draft.rounds.count == total_rounds
          flash[:notice] = "Draft Complete"
          render "leagues/show"
        end
        current_round = @round.number + 1
        @round = @draft.rounds.create(number: current_round)
      end
      @players = Player.where.not(id: @drafted_player_ids)
      @drafting_team.set_position(@drafted_player, @drafting_team_roster)
      current_pick_number = params[:pick][:number].to_i + 1
      @pick = Pick.new(number: current_pick_number)
      @team_lineups = {}
      @teams.each do |team|
        @team_lineups[team.id] = team.project_lineup
      end
      render "drafts/show", layout: false
    elsif @drafting_team.active_roster_count < @league.max_players
      binding.pry
      @error = "#{@drafting_team.name}'s roster is full."
      render "leagues/show"
    else
      binding.pry
      flash[:notice] = "Something went wrong. Leave feedback or try again later."
      render "leagues/show"
    end
  end
end
