class FriendsController < ApplicationController
    before_action :require_user
    def index
        @friends = current_user.friends_with.paginate(page: params[:page], per_page: 5)
    end

    def show
    end

    def block
        current_user.block_friend(params[:friend][:id])
        flash[:success] = "You block successfull"
        redirect_to friends_path
    end

    def unblock
        current_user.unBlock(params[:friend][:id])
        flash[:success] = "You unblock successfull"
        redirect_to friends_path
    end

    def create
        current_user.make_friend(params[:friend][:id])
        flash[:success] = "Make friend is successfull"
        redirect_to users_path
    end

    def destroy
        
        current_user.unfriend(params[:id])
        flash[:danger] = "Unfriend is successfull"
        redirect_to friends_path
    end

    private

end
