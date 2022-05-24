class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
    @order = Order.new
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :deadline_delivery)
    @order = Order.new(order_params)
    @order.user = current_user
    @order.save
    redirect_to @order , notice: 'Pedido registrado com sucesso'
  end

  def show
    @order = Order.find(params[:id])
  end
end