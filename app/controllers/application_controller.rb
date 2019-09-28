class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :current_user
  before_action :set_locale


  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def logged_in?
    session[:user_id].present?
  end

  def current_user
    if logged_in?
      @current_user = User.find(session[:user_id])
      if @current_user.present?
        return @current_user
      end
    end

  end

  def ensure_authenticated
    unless(logged_in?)
      redirect_to new_session_path
    end
  end

end
