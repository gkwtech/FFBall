class LeaguesController < ApplicationController
  before_action :authenticate

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.commissioner_id = current_user.id
    if @league.save
      flash[:notice] = "League created"
      redirect_to league_path(@league)
    else
      @errors = @league.errors.full_messages
      render :new
    end
  end

  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
    @teams = @league.teams
  end

  private

  def league_params
    params.require(:league).permit(:name, :password, :member_amount)
  end
end
