class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @product_models = ProductModel.all
  end

  def new
    @suppliers = Supplier.all
    @product_model = ProductModel.new
  end

  def create
    
    product_model_params = params.require(:product_model).permit(:name, :sku,
                                :height,:width ,:depth , :weight, :supplier_id)
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to @product_model, notice: 'Produto cadastrado com sucesso'
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar o produto'
      render 'new'
    end
  end

  def show
    @product_model= ProductModel.find(params[:id])
  end


end