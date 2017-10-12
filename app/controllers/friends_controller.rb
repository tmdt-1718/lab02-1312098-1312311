class FriendsController < ApplicationController

    def index
        @friends = current_user.friends_with
    end

    def show

    end

    def block
        @friend = Friend.find_by(user_id: current_user.id, friend_id: params[:friend][:id]  )
        @friend.block = true
        @friend.save
        flash[:success] = "You block successfull"
        redirect_to friends_path
    end

    def unblock
        @friend = Friend.find_by(user_id: current_user.id, friend_id: params[:friend][:id]  )
        @friend.block = false
        @friend.save
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
        redirect_to users_path
    end

    private

end
