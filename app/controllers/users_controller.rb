class UsersController < ApplicationController

  before_filter :load_user, :only => [:load_users, :load_data_table]

  def index
  end

  def load_users
    render :json => [{:title => @user.full_name, :id => @user.id, :children => load_children(@user)} ]
  end

  def load_data_table
    levels = {"1" => [], "2" => [], "3" => [], "4" => [], "5" => []}
    h = {:aaData => []}
    get_level_users(@user, levels).each_pair do |level, users|
      active_users = 0
      users.each{|u| active_users = active_users+1 if u.active?}
      users_count = users.size
      h[:aaData] << [level, users_count, active_users, users_count - active_users, 
        active_users * User::COEF_CARD["#{level}"], active_users * User::COEF_BALANS["#{level}"] ]
    end
    render :json => h
  end

  def details_information
    @user = User.find_by_id(params[:id])
    render :layout => false
  end

  private

  def get_level_users(user, levels, level = 1)
    user.children.each do |child|
      levels["#{level}"] << child
      get_level_users(child, levels, level+1) if level+1 <= 5
    end
    levels
  end

  def load_children(user, level = 0)
    children = []
    user.children.each do |child|
      children << {:title => child.full_name, :id => child.id, :children => load_children(child, level+1)} if level+1 <= 5
    end
    children
  end

  def load_user
    begin
      @user = User.find_by_id(params[:id])
      raise if @user.nil? || @user.id != current_user.id
    rescue
      redirect_to root_path
    end
  end

end

