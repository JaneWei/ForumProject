class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
    # Sign the user in and redirect to the user's show page.
			if params[:remember_me]
				# remember user's auth_token forever
				cookies.permanent[:auth_token] = user.auth_token
			else 	
				cookies[:auth_token] = user.auth_token
			end
     	  sign_in user
        redirect_back_or user
    else
    # Create an current page error message and re-direct to new page.
      flash.now[:error] = 'Invalid email/password combination'
			render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, :notice => "You have logged out!"
  end


end
