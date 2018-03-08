class SessionsController <ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user_name], params[:password])
    fail
    if user
      session[:session_token] = user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:error] = "Wrong Username and Password"
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
    end

    session[:session_token] = nil
  end

end
