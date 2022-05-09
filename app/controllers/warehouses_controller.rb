class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :adress, :zip_code, :area)
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
    redirect_to root_path, notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Erro! Não foi possível cadastrar um novo galpão'
      render 'new' 
    end
  end
end