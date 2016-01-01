class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CurrentUser

  before_action :set_development_console

  before_action :authorize

  protected
    def authorize
      redirect_to login_path, notice: "Please Log In" unless current_user.present?
    end

  private
    def set_development_console
      console
    end
end
