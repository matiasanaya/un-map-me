class ApplicationController < ActionController::Base
  protect_from_forgery
  # force_ssl # should be added in production
  before_filter :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
