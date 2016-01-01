module CurrentUser
  extend ActiveSupport::Concern

  private

    def current_user
      User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      nil
    end

end
