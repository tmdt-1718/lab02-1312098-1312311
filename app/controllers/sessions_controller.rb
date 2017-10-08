class SessionsController < ApplicationController
    def new 
        
    end

    def create 
        if params[:session]
            user = User.find_by(email: params[:session][:email].downcase)
            if user && user.authenticate(params[:session][:password])
                session[:user_id] = user.id
                # LoginMailer.login_successfully(user).deliver_now
                flash[:success] = "You have successfully logged in"
                redirect_to user_path(user)
            else
                flash.now[:danger] = "There was something wrong with your login information"
                render 'new'
            end
        else 
            auth = request.env["omniauth.auth"]
            session[:omniauth] = auth.except('extra')
            user = User.sign_in_from_omniauth(auth)
            session[:user_id] = user.id
            redirect_to user_path(user)
        end
    end

    def destroy
        session[:user_id] = nil
        # session[:omniauth] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end
end
