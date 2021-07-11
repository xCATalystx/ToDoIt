class ApplicationController < ActionController::Base
  before_action :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end
  
  private
  def not_found
    render file: "public/404.html", layout: false, status: 404
  end
end
