class Api::Delectable::OrderController < ApplicationController
  respond_to :json

  def index
    orders = Order.all
    render json: orders, status: 200
  end

  def create
    order=Order.new(order_params)
    # if the order is saved successfully than respond with json data and status code 201
    if order.save
      render json: Order.all, status: 200
    else
      render json: "422", status: 422
    end
  end

  private
  def order_params
    params.require(:order).permit(:foods, :surcharge, :ship, :billing, :instructions, :status, :name, :email, :phone, :notes)
  end

end
