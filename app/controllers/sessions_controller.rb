class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by_name params[:name]
    if user.present? && user.authenticate(params[:password]).present?
      session[:user_id] = user.id
      redirect_to admin_path
    else
      redirect_to login_path, notice: "Invalid username/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_path, notice: "Logged out"
  end
end
