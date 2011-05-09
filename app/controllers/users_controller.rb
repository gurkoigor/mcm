class UsersController < ApplicationController

  before_filter :load_user, :only => [:load_users, :load_data_table]

  def index
  end

  def load_users
    children = load_children(@user)
    render :json => [{:title => @user.email, :children => children} ]
  end

  def load_data_table
    levels = {"1" => [], "2" => [], "3" => [], "4" => [], "5" => []}
    h = {:aaData => []}
    get_level_users(@user, levels).each_pair do |level, users|
      users_count = users.size
      h[:aaData] << [level, users_count, users_count * User::COEF_CARD["#{level}"],
                     users_count * User::COEF_BALANS["#{level}"] ]
    end
    render :json => h
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
      children << {:title => child.email, :children => load_children(child, level+1)} if level+1 <= 5
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

