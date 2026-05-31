class SessionsController < ApplicationController
  def new
    # TODO: render login form in session/new.html.erb
  end
  
  def create
    # TODO: authenticate user
    # 1. try to find user by their unique identifier (e.g. email)
    @user = User.find_by({ "email" => params["email"] })
    # 2. if found, check if their password is correct
    if @user != nil
      # 3. if they know their password -> login is successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
      session["user_id"] = @user["id"]
      flash["notice"] = "Welcome, #{@user["first_name"]}."
      redirect_to "/posts" 
      else
      # 4b. if the user doesn't know their password -> login fails
      flash["alert"] = "Nope."
      redirect_to "/login"
      end
    else
      # 4a. if the user doesn't exist -> login fails
    flash["alert"] = "User not found."
    redirect_to "/login"
    end
  end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end
end
