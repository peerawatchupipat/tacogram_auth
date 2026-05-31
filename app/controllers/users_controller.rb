class UsersController < ApplicationController
  def new
  end

  def create
    if User.find_by({ "email" => params["email"] }) == nil
      @user = User.new
      @user["first_name"] = params["first_name"]
      @user["last_name"] = params["last_name"]
      @user["email"] = params["email"]
      # TODO: encrypt user's password "at rest"
      encrypted_password = BCrypt::Password.create(params["password"])
      @user["password"] = encrypted_password
      # @user["password"] = params["password"] --- IGNORE ---
      @user.save
      redirect_to "/login"
    else
      flash["alert"] = "Email taken."
      redirect_to "/users/new"
    end
  end
end
