class Admin::UsersController < ApplicationController

  before_filter :load_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
    #render :layout => 'ui_templates'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Пользователь создан"
      redirect_to edit_admin_user_path(@user)
    else
      flash[:error] = "Пользователь не создан"
      render :action => :new
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Пользователь обновлен"
      redirect_to edit_admin_user_path(@user)
    else
      flash[:error] = "Пользователь не обновлен"
      render :action => :edit
    end
  end

  private

  def load_user
    @user = User.find_by_id(params[:id])
  end

end

