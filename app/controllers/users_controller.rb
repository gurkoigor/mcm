class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :load_user, :only => [:load_users]

  def index
  end

  def load_users
    children = load_children(@user)
    render :json => [{:title => @user.email, :children => children} ]
  end

  private

  def load_children(user)
    children = []
    user.children.each do |child|
      children << {:title => child.email, :children => load_children(child)} if child.ancestors.size < 5
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

