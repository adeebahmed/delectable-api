class Api::Delectable::MenuController < ApplicationController
  respond_to :json

  def index
    menus = Menu.all
    render json: menus, status: 200
  end

  def show
    begin
      menu = Menu.find(params[:id])
    rescue
      menu = nil
    end

      if !menu.nil?
        render json: menu, status: 200
      else
        render json: "404", status: 404
      end
  end

  # def create
  #   menu=Menu.new(menu_params)
  #   # if the menu is saved successfully than respond with json data and status code 201
  #   if menu.save
  #     render json: menu, status: 200
  #   else
  #     render json: { errors: menu.errors}, status: 422
  #   end
  # end

  # # Updating menus
  # def update
  #   menu = Menu.find(params[:id])
  #
  #   if menu.update(menu_params)
  #     render json: menu, status: 200
  #   else
  #     render json: { errors: menu.errors }, status: 422
  #   end
  # end
  #
  # # Deleting menus
  # def destroy
  #   menu = Menu.find(params[:id])
  #   menu.destroy
  #   head 204
  # end

  private
  def menu_params
    params.require(:menu).permit(:menuname)
  end
end
