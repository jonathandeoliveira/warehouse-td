class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
    @order = Order.new
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :deadline_delivery)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order , notice: 'Pedido registrado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível criar a ordem de serviço'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end
end