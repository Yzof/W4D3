class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :is_logged?

  def current_user
    @current_user ||= User.find(session_token: :session[:session_token])
  end

  def is_logged?
    !!@current_user
  end

  def login!

  end

  def logout!

  end

end
