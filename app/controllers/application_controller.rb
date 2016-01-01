class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CurrentUser

  before_action :authorize
  before_action :set_i18n_locale_from_params
  # before_action :set_development_console

  protected
    def authorize
      redirect_to login_path, notice: "Please Log In" unless current_user.present?
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash[:notice] = "#{params[:locale]} translation not available"
          logger.error flash[:notice]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

  private
    def set_development_console
      console if Rails.env.development?
    end
end
