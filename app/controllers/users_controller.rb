class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to Email App"
            redirect_to edit_user_path(@user)
        else
            render 'new'
        end
    end

    def edit
        
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to edit_user_path(@user)
        else
            render 'edit'
        end
    end

    def show

    end

    def destroy
     
    end

    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :avatar)
        end

        def set_user
            @user = User.find(params[:id])
        end
end
