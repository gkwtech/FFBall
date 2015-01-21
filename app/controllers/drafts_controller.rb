class DraftsController < ApplicationController
  before_action :authenticate, :commissioner_authenticate
  def index
  end
  def show
  end
  def new
    @league = League.find(params[:league_id])
    render layout: false
  end
  def create
  end
end
