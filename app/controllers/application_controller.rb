class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :set_ransack_obj

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :server_error
  
  def current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform this action!"
      redirect_to sign_in_path
    end
  end
  
  private
  def set_ransack_obj
    @q = Current.user.tasks.ransack(params[:q])
  end
  
  def not_found
    render file: "public/404.html", layout: false, status: 404
  end

  def server_error
    render file: "public/500.html", layout: false, status: 500
  end
end
