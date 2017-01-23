class Api::Delectable::UsersController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def index
    users = User.all
    render json: users, status: 200
  end

  def show
    if (is_number?(params[:id]) == false && params[:id].include?('@')) # search by email
      find_users(nil,params[:id], nil)

    elsif (is_number?(params[:id]) == false) # search by lastname
      find_users(params[:id],nil,nil)

    elsif (is_number?(params[:id]) && params[:id].length == 10) # search by phone number
        find_users(nil,nil,params[:id])

    elsif (params[:id].to_i != 0) # search by id
        user = User.find(params[:id])
        if(user.nil? == false)
          render json: user, status: 200
        else
          render json: { errors: user.errors }, status: 404
        end

    else
      render json: 'Error: Invalid Argument - Try {lastname, phone, email}', status: 404
    end
  end

  def find_users(lname, email, phone)
    if (email.nil? == false)
    users = User.search_by_email(email)
    elsif (lname.nil? == false)
      users = User.search_by_last_name(lname)
    elsif (phone.nil? == false)
      users = User.search_by_phone(phone)

    end

    if(users.exists?)
      render json: users, status: 200
    else
      render json: users.errors, status: 404
    end

  end

  def is_number?(string)
    true if Float(string) rescue false
  end



  def create
    user=User.new(user_params)
    # if the user is saved successfully than respond with json data and status code 201
    if user.save
      render json: user, status: 200
    else
      render json: { errors: user.errors}, status: 422
    end
  end

  # Updating users
  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  # Deleting users
  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :phone)
  end

end
