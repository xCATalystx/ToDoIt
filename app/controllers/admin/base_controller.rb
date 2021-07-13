class Admin::BaseController < ApplicationController
  layout 'backend'
  before_action :login_check
  before_action :admin_check

  def login_check
    if !logged_in?
      redirect_to admin_sign_in_path, notice: '請先登入'
    end
  end

  def admin_check
    if !current_user.admin
      redirect_to admin_sign_in_path, notice: '權限不足'
    end
  end
end
