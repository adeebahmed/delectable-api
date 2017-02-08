class MenuController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    menus = Menu.all
    render json: menus, status: 200
  end

  def show

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
