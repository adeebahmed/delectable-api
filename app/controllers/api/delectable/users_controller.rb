class Api::Delectable::UsersController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token

  def show
    respond_with User.find(params[:id])
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

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :phone)
  end

end