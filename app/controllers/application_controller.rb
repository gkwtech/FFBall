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
end
