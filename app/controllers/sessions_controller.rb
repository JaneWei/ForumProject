require 'open-uri'
require 'nokogiri'
require 'timeout'
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

	def search
	 params[:query].downcase! 
	 @searchItem = params[:query]
	 @searchItem.strip!
	 @searchItem.gsub!("%20"," ")
	 @searchItemTitle = params[:queryT]
	 #@serachItemTitle = modifyTitle @searchItemTitle
	 @searchItemTitle.strip!
	 @buzzilaAPI = "http://api.buzzilla.com/buzzilla/query?token=de4bd5c9-cbe3-437d-b870-751141cdd803&dataType=xml&pageNum=1&sortBy=relevance&query=forum:"
	 if !@searchItemTitle.empty?
	   @searchURL = @buzzilaAPI + @searchItem + "%20intitle:" + @searchItemTitle
	 else	
			@searchURL = @buzzilaAPI + @searchItem
	 end
   # fix the whitspace bug
	 @searchURL.gsub!(/ /,"%20") 

	 #begin 
		#status = Timeout::timeout(6){
 	 @searchResult = open(@searchURL,"UserAgent" => "Ruby-OpenURI").read
  	#}
	 #rescue Timeout::Error =>e
		 #redirect_to root_path, :notice => "Server in maintainence"
	 #end
	 @links = Nokogiri::XML(@searchResult)
	 @res = Array.new
	 @links.xpath("//item").each do |n|
		 @res << ( n.xpath('link').inner_text )
   end
	 if @res
			session[:res] = @res
		  redirect_to current_user 
	 else
	    redirect_to current_user, :notice => @searchURL , :notice => "Please Input again."
	 end
	end 
	
	private
			def modifyTitle words
				

			end

end
