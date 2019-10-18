class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :current_user
  before_action :set_locale


  def set_locale
    logger.debug "params locale: #{params[:locale]}\n".green
    logger.debug "session locale before: #{session[:locale]}\n".green

    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
    logger.debug "session locale after: #{session[:locale]}\n".green
  end

  def default_url_options
    logger.debug "default_url_options is passed options: #{I18n.locale}\n".blue
    { :locale => ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
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
