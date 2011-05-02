class Admin::TariffsController < ApplicationController
  before_filter :load_tariff, :only => [:edit, :update, :destroy]

  def index
    @tariffs = Tariff.all
  end

  def new
    @tariff = Tariff.new
  end

  def create
    @tariff = Tariff.new(params[:tariff])
    if @tariff.save
      flash[:notice] = "Тариф создан"
      redirect_to :action => :edit, :id => @tariff.id
    else
      flash[:error] = "Тариф не создан"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @tariff.update_attributes(params[:tariff])
      flash[:notice] = "Тарфи обновлен"
      redirect_to :action => :edit, :id => @tariff
    else
      flash[:error] = "Тарфи не обновлен"
      render :action => :edit
    end
  end

  def destroy
    if @tariff.destroy
      flash[:notice] = "Тариф удален"
    else
      flash[:error] = "Тариф не удален"
    end
    redirect_to :action => :index
  end

  private

  def load_tariff
    @tariff = Tariff.find_by_id(params[:id])
  end

end
