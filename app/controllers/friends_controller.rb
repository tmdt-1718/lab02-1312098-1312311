class FriendsController < ApplicationController

    def index
        @user = User.all
    end

    def show

    end

    private

end
