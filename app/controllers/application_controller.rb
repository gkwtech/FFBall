class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    if current_user.nil?
      flash[:notice] = "Must be signed in to do that."
      redirect_to new_user_session_path
    end
  end

  def commissioner_authenticate
    league = League.find(params[:league_id])
    if league.commissioner_id != current_user.id
      flash[:notice] = "Only the commissioner can do that"
      redirect_to league_path(league)
    end
  end
end
