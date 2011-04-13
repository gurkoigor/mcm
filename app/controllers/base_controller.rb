class BaseController < ApplicationController
  before_filter :only_admin

  private

  def only_admin
    redirect_to root_path unless current_user.admin?
  end
end

