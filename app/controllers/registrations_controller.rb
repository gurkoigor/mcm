class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    @parent_user = User.find_by_id(params[:user][:parent_id])
    @user = User.new(params[:user])
    if @parent_user.nil?
      flash[:alert] = "Пользователь не найден"
      render :action => :new
    else
      if @user.save
        flash[:notice] = "Вы успешно зарегестрированы в сети"
        redirect_to root_path
      else
        flash[:alert] = "Вы не зарегестрированы"
        render :action => :new
      end
    end
  end

end

