class ApplicationController < ActionController::Base
  protect_from_forgery
  # force_ssl # should be added in production
  
  include SessionsHelper
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  private

  def current_user
    @current_user ||= User.find_by_remember_token(session[:remember_token]) if session[:remember_token]
  end

  helper_method :current_user
end
