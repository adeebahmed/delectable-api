class Api::Delectable::AdminController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    admins = Admin.all
    render json: admins, status: 200
  end

  # PUT updates menu with new menu item
  def show
    menu = Menu.all.last # grabs the latest menu
    createMenuIfRequired(menu)

  end

  def createMenuIfRequired(menu)
    # if no menu exists then create one
    if (menu.nil?)
      menu = Menu.new(params[:menuname => "Delectable Menu"])
      # if the menu is saved successfully than respond with json data and status code 201
      if menu.save
        render json: menu, status: 200
      else
        render json: { errors: menu.errors}, status: 422
      end
    end
  end

  # def create
  #   admin=Admin.new(admin_params)
  #   # if the admin is saved successfully than respond with json data and status code 201
  #   if admin.save
  #     render json: admin, status: 200
  #   else
  #     render json: { errors: admin.errors}, status: 422
  #   end
  # end
  #
  # # Updating admins
  # def update
  #   admin = Admin.find(params[:id])
  #
  #   if admin.update(admin_params)
  #     render json: admin, status: 200
  #   else
  #     render json: { errors: admin.errors }, status: 422
  #   end
  # end
  #
  # # Deleting admins
  # def destroy
  #   admin = Admin.find(params[:id])
  #   admin.destroy
  #   head 204
  # end

  private
  def admin_params
    params.require(:admin).permit(:firstname, :lastname, :surcharge)
  end

  private
  def food_params
    params.require(:admin).permit(:foodname, :category, :calories, :price, :minorder)
  end

  private
  def menu_params
    params.require(:admin).permit(:menuname == 'Delectable Menu')
  end

end
