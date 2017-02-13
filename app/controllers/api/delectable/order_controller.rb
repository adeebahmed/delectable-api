class Api::Delectable::OrderController < ApplicationController
  respond_to :json

  def index
    orders = Order.all
    render json: orders, status: 200
  end

  def show
    if (params[:id].to_i != 0)
      order = Order.find(params[:id])
      render json: order, status: 200
      if(order.nil? == false)
        render json: order, status: 200
      else
        render json: "404", status: 404
      end
    #elsif(params[:id].length == 8 & params[:id].isdate)

    end
  end

  def create
    order=Order.new(order_params)
    order.surcharge = Admin.first.surcharge.to_s
    # if the order is saved successfully than respond with json data and status code 201
    if order.save
      render json: '[{"order": {"id":' + order.id.to_s + ','  + '"cancel_url": /order/cancel/' + order.id.to_s + '}}]', status: 200
    else
      render json: "422", status: 422
    end
  end

  private
  def order_params
    params.require(:order).permit(:foods, :surcharge, :ship, :billing, :instructions, :status, :name, :email, :phone, :notes, :deliverydate)
  end

end
