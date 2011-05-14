class Admin::UsersController < ApplicationController

  before_filter :load_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
    #render :layout => 'ui_templates'
  end

  def new
    @user = User.new
    @phones = @user.phones.build
  end

  def create
    @user = User.new(params[:user])
    @user.admin = params[:user][:admin]
    @user.date_of_trip = params[:user][:date_of_trip]
    if @user.save
      flash[:notice] = "Пользователь создан"
      redirect_to edit_admin_user_path(@user)
    else
      @phones = @user.phones.build if @user.phones.empty?
      flash[:error] = "Пользователь не создан"
      render :action => :new
    end
  end

  def edit
    @phones = @user.phones
    @phones = @user.phones.build if @phones.empty?
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:password_confirmation].blank?
    end if params[:user]

    if @user.update_attributes(params[:user])
      @user.admin = params[:user][:admin]
      @user.date_of_trip = params[:user][:date_of_trip]
      @user.save
      @user.create_tariff
      flash[:notice] = "Пользователь обновлен"
      redirect_to edit_admin_user_path(@user)
    else
      flash[:error] = "Пользователь не обновлен"
      render :action => :edit
    end
  end

  def destroy
    unless @user.parent_id.zero?
      if @user.children.update_all(:parent_id => @user.parent_id)
        if @user.destroy
          flash[:notice] = "Пользователь удален"
        else
          flash[:error] = "Пользователь не удален"
        end
      end
    else
      flash[:error] = "Главный пользователь системы не может быть уделен"
    end
    redirect_to :action => :index
  end

  def load_users
    @users = []
    @users = User.where(["email like ?", "%#{params[:user_email]}%"])
    @users = @users.map{|u| {:label => u.email, :value => u.id}} unless @users.nil?
    render :json => @users
  end

  def add_phone; end

  private

  def load_user
    @user = User.find_by_id(params[:id])
  end

  def set_tariff

  end

end

