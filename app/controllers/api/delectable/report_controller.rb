class Api::Delectable::ReportController < ApplicationController

  def index
    generate_reports
    reports = Report.all
    render json: reports, status: 200
  end

  def generate_reports
    if (Report.first.nil?) # generate reports if they dont exist
      report = Report.new(:reportname => 'Orders to deliver today')
      report.save
      report = Report.new(:reportname => 'Orders to deliver tomorrow')
      report.save
      report = Report.new(:reportname => 'Revenue Report')
      report.save
      report = Report.new(:reportname => 'Orders Delivery Report')
      report.save
    end
  end

  def show
    if(params[:id].to_s == '1')
      generate_todays_report
    elsif (params[:id].to_s == '2')
      generate_tommorows_report
    elsif (params[:id].to_s == '3')
      rev_report(params[:start_date], params[:end_date])
    else
        render json: "404", status: 404
    end
  end

  def generate_todays_report
    report = Report.find(params[:id])
    time = DateTime.now
    orders = Order.where("deliverydate > ? AND deliverydate < ?", time - 2.day, time - 1.day)
    orderTotal = 0
    foods = Array.new

    orders.each do |order|
      if !order.status.include?('cancel')
      order = order.foods
      order = order.split('|')

        order.each do |food|
          foodid = food.split(',')[0]
          foodqty = food.split(',')[1]
          fooditem = Menu.find(foodid)
          foods.push(fooditem)
          orderTotal += (fooditem.price * foodqty.to_i)
        end
      end
    end
    if(orders.nil? == false)
      render json:{:report => report,  :total => '%.2f' % orderTotal, :order => [orders, foods]}, :except=> [:created_at,:updated_at], status: 200
    else
      render json: "404", status: 404
    end
  end

  def generate_tommorows_report
    report = Report.find(params[:id])
    time = DateTime.now
    orders = Order.where("deliverydate > ? AND deliverydate < ?", time-1.day, time)
    orderTotal = 0
    fooditem = nil
    foods = Array.new

    orders.each do |order|
      if !order.status.include?('cancel')
      order = order.foods
      order = order.split('|')

        order.each do |food|
          foodid = food.split(',')[0]
          foodqty = food.split(',')[1]
          fooditem = Menu.find(foodid)
          foods.push(fooditem)
          orderTotal += (fooditem.price * foodqty.to_i)
        end
      end
    end


    if(orders.nil? == false)
      render json:{:report => report,  :total => '%.2f' % orderTotal, :order => [orders, foods]}, :except=> [:created_at,:updated_at], status: 200
    else
      render json: "404", status: 404
    end
  end

  def rev_report(startdate,enddate)
    report = Report.find(params[:id])
    orders = Order.where("deliverydate > ? AND deliverydate < ?", DateTime.parse(startdate) - 2.day, DateTime.parse(enddate) - 1.day)
    orderTotal = 0
    foods = Array.new
    ordersCanceled = 0
    surchargeTotal = 0

    orders.each do |order|
      if !order.status.include?('cancel')
        surchargeTotal += order.surcharge.to_f

      order = order.foods
      order = order.split('|')
        order.each do |food|
          foodid = food.split(',')[0]
          foodqty = food.split(',')[1]
          fooditem = Menu.find(foodid)
          foods.push(fooditem)
          orderTotal += (fooditem.price * foodqty.to_i)
        end
      else
        ordersCanceled = ordersCanceled + 1
      end
    end
    if(orders.nil? == false)
      ordersOpen = orders.length - ordersCanceled
      render json:{:report => [report, :start_date => startdate, :end_date => enddate, :orders_placed => orders.length,
                               :orders_cancelled => ordersCanceled, :orders_open => ordersOpen, :order_total => orderTotal,
                               :surcharge_total => surchargeTotal]}, :except=> [:created_at,:updated_at], status: 200
    else
      render json: "404", status: 404
    end
  end

end
