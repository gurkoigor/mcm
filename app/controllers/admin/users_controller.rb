class Admin::UsersController < ApplicationController

  def index
    @users = User.all
    #render :layout => 'ui_templates'
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

end

