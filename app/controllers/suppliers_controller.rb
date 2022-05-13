class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
      if @supplier.save
        redirect_to @supplier, notice: 'Fornecedor cadastrado com sucesso!'
      else
        flash.now[:alert] = 'Erro! Fornecedor não cadastrado.'
        render 'new'
      end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      return redirect_to supplier_path(@supplier.id), notice:'Fornecedor atualizado com sucesso'
    else 
      flash.now[:notice] = 'Não foi possível atualizar o fornecedor'
      render 'edit'
    end
  end

  private 

  def supplier_params
    params.require(:supplier).permit(:company_name, :company_register, 
           :brand_name, :adress, :city, :state, :email, :phone_number)
  end

end