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
    else
        render json: "404", status: 404
    end
  end

  def generate_todays_report
    report = Report.find(params[:id])
    time = DateTime.now
    orders = Order.where("deliverydate > ? AND deliverydate < ?", time - 1.day, time)
    orderTotal = 0
    fooditem = nil
    foods = Array.new

    orders.each do |order|
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
    if(orders.nil? == false)
      render json:{:report => report, :order => orders, :foods => foods, :total => '%.2f' % orderTotal}, status: 200
    else
      render json: "404", status: 404
    end
  end

  def generate_tommorows_report
    report = Report.find(params[:id])
    time = DateTime.now
    orders = Order.where("deliverydate > ? AND deliverydate < ?", time, time + 1.day)
    orderTotal = 0
    fooditem = nil
    foods = Array.new

    orders.each do |order|
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


    if(orders.nil? == false)
      render json:{:report => report, :order => orders, :foods => foods, :total => orderTotal}, status: 200
    else
      render json: "404", status: 404
    end
  end


end
