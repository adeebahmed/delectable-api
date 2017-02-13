class Api::Delectable::AdminController < ApplicationController
  respond_to :json

  def index
     admins = Admin.all
     render json: admins, status: 200
  end

  # PUT updates menu with new menu item
  def show
    menu=Menu.new(menu_params)
    # if the admin is saved successfully than respond with json data and status code 201
    if menu.save
      render json: Menu.all, status: 200
    else
      render json: { errors: menu.errors}, status: 422
    end
    # if(params[:id].include?("menu"))
    #   render json: "Test", status: 200
    # end
    #
    # menu = Menu.all.last # grabs the latest menu
    # render json: menu, status: 200
  end

  # def createMenuIfRequired(menu)
  #   # if no menu exists then create one
  #   if (menu.nil?)
  #     menu = Menu.new(params[:menuname => "Delectable Menu"])
  #     # if the menu is saved successfully than respond with json data and status code 201
  #     if menu.save
  #       render json: menu, status: 200
  #     else
  #       render json: { errors: menu.errors}, status: 422
  #     end
  #   end
  # end

  # def createAdminIfRequired()
  #   # if no menu exists then create one
  #   admins = Admin.first
  #   if (admins.nil?)
  #     a = Admin.new(admin_params)
  #     # if the menu is saved successfully than respond with json data and status code 201
  #     if a.save
  #       render json: a, status: 200
  #     else
  #       render json: { errors: a.errors}, status: 422
  #     end
  #   end
  # end

  def create
    admin=Admin.new(admin_params)
    # if the admin is saved successfully than respond with json data and status code 201
    if admin.save
      render json: Admin.all, status: 200
    else
      render json: { errors: admin.errors}, status: 422
    end
  end

  def updatemenu
      menuItem = Menu.find(params[:id])

      if menuItem.update(update_params)
        render json: menuItem, status: 204
      else
        render json: { errors: menuItem.errors }, status: 400
      end
  end

  def getsurcharge
      surcharge = Admin.first.surcharge

      if(!surcharge.nil?)
        render json: surcharge, status: 200
      else
        render json: { errors: Admin.first.errors }, status: 400
      end
  end

  def postsurcharge
    surcharge = Admin.first

    if surcharge.update(surcharge_params)
      render json: surcharge, status: 204
    else
      render json: { errors: surcharge.errors }, status: 400
    end
  end

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
    params.require(:admin).permit(:email, :password, :password_confirmation, :firstname, :lastname, :surcharge)
  end

  private
  def menu_params
    params.require(:menu).permit(:id, :menuitem, :price, :category, :calories)
  end

  private
  def update_params
    params.require(:menu).permit(:id, :price)
  end

  private
  def surcharge_params
    params.require(:admin).permit(:surcharge)
  end
end
